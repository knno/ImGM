local projectName = "ImGM"

-- #region Utils

function toPascalCase(str)
    local words = string.gsub(str, "[^a-zA-Z0-9]+", " "):gmatch("%S+")
    local pascalCase = ""
    for word in words do
        pascalCase = pascalCase .. word:sub(1, 1):upper() .. word:sub(2):lower()
    end
    return pascalCase
end

function getEnabledExts(configFile)
    local enabled = {}
    local f = io.open(configFile, "r")
    if f then
        for line in f:lines() do
            local ext = line:match("^%s*#define%s+IMEXT_([A-Za-z0-9_]+)")
            if ext then
                enabled[ext:lower()] = true
            end
        end
        f:close()
    end

	local anyEnabled = false
	for extName, _ in pairs(enabled) do
		if (not anyEnabled) then
			print("ImGui extensions:")
			anyEnabled = true
		end
		print("  - " .. extName)
	end
	if (not anyEnabled) then
		print("ImGui extensions: None")
	end

	return enabled
end

function buildExtIncludeDirs(baseDir, enabledExts)
    local exts = os.matchdirs(baseDir .. "/*")
    local incs = {}
    for _, ext in ipairs(exts) do
        local extName = string.match(ext, baseDir .. "/(.+)/?")
        if enabledExts[extName:lower()] then
            print("Adding include dirs for: " .. extName)
            table.insert(incs, ext)
            table.insert(incs, ext .. "/internal")
        else
            -- skipped extName
        end
    end
    return incs
end

function buildExtFiles(baseDir, enabledExts)
    local exts = os.matchdirs(baseDir .. "/*")
    local filesList = {}
    for _, ext in ipairs(exts) do
        local extName = string.match(ext, baseDir .. "/(.+)/?")
        if enabledExts[extName:lower()] then
            print("Adding files for: " .. extName)
            table.insert(filesList, ext .. "/*.h")
            table.insert(filesList, ext .. "/*.cpp")
            table.insert(filesList, ext .. "/*.inl")
            table.insert(filesList, ext .. "/**/*.h")
            table.insert(filesList, ext .. "/**/*.cpp")
            table.insert(filesList, ext .. "/**/*.inl")
        else
            -- skipped extName
        end
    end
    return filesList
end

local dllDir = "src/dll/"
local toolsDir = "src/tools/"
local gmProjectDir = "src/gm/" .. projectName .. "/"
local gmProjectExtDir = gmProjectDir .. "extensions/" .. projectName .. "/"
local enabledExts = getEnabledExts(dllDir .. "config.h")
local extIncDirs = buildExtIncludeDirs(dllDir .. "imext", enabledExts)
local extFiles = buildExtFiles(dllDir .. "imext", enabledExts)

function processImext(baseDir)
    local exts = os.matchdirs(baseDir .. "/*")
    for _, ext in ipairs(exts) do
        local extName = string.match(ext, baseDir .. "/(.+)/?")
		if enabledExts[extName:lower()] then
			local pascalCaseExtName = toPascalCase(extName)
			_vpaths[pascalCaseExtName .. "/Internal"] = {
				ext .. "/internal/*.*",
				ext .. "/internal/**/*.*",
			}
			_vpaths[pascalCaseExtName .. "/Wrappers"] = {
				ext .. "/wrappers/*.*",
				ext .. "/wrappers/**/*.*",
			}
			_vpaths[pascalCaseExtName .. "/*"] = {
				ext .. "/*.h",
				ext .. "/*.cpp",
				ext .. "/*.inl",
			}
		end
    end
end

-- #endregion

workspace "dll"
    configurations { "Debug", "Release" }
    location(dllDir)
    architecture "x86_64"

project(projectName)
    kind "SharedLib"
    language "C++"
    cppdialect "C++14"
    targetdir(gmProjectExtDir)
    defines { "GDKEXTENSION_EXPORTS", "__YYDEFINE_EXTENSION_FUNCTIONS__" }

    includedirs {
        dllDir,
        dllDir .. "internal",
        dllDir .. "imgui",
        dllDir .. "imgui/internal",
		table.unpack(extIncDirs),
    }

    files {
        dllDir .. "config.h",
        dllDir .. "internal/gm.h",
        dllDir .. "*.h",
        dllDir .. "*.cpp",
        dllDir .. "imgui/*.h",
        dllDir .. "imgui/*.cpp",
        dllDir .. "imgui/**/*.h",
        dllDir .. "imgui/**/*.cpp",
        dllDir .. "imgui/**/*.inl",
        dllDir .. "imgui/internal/im*.h",
        dllDir .. "imgui/internal/im*.cpp",
		table.unpack(extFiles),
    }

    excludes {
        dllDir .. ".old.*",
        dllDir .. "**/.old.*",
        -- dllDir .. "imext/**/internal/*.*",
        -- dllDir .. "imext/**/internal/**/*.*",
    }

	_vpaths = {
		["Config"] = {
			dllDir .. "config.h",
			dllDir .. "internal/gm.h",
		},
		["ImGui/*"] = {
			dllDir .. "imgui/*.h",
			dllDir .. "imgui/*.cpp",
		},
		["ImGui/Internal"] = {
			dllDir .. "imgui/internal/*.*",
			dllDir .. "imgui/internal/**/*.*",
		},
		["ImGui/Wrappers"] = {
			dllDir .. "imgui/wrappers/*.*",
			dllDir .. "imgui/wrappers/**/*.*",
		},
	}
	processImext(dllDir .. "imext")
	vpaths(_vpaths)
	objdir("../../temp/$(ShortProjectName)/$(Platform)/$(Configuration)/")

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		-- postbuildcommands { "set NO_COLOR=1 && npm run wrappers:gen" }

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		-- postbuildcommands { "set NO_COLOR=1 && npm run wrappers:gen" }

	-- Windows
	filter { "action:vs*" }
		defines "OS_Windows"

	-- Ubuntu
	filter { "action:gmake*" }
		if _OPTIONS["os"] == "linux" or os.ishost("linux") then
			defines "OS_Linux"
			pic "on"
			targetextension ".so"
			buildoptions {
				"-shared", "-o " .. gmProjectExtDir .. projectName .. ".so", "-Werror",
			}
		else
			defines "OS_Mac"
		end

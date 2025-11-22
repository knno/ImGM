import path from "path"

export const projectRoot =
	path.dirname(process.env.npm_package_json) ?? // resolve root: npm run
	path.join(import.meta.dirname, "../../../") // resolve root: node ES module

/**
 * modules configs (Config.modules.*)
 */
const modulesConfig = {
	/**
	 * ImGui module
	 */
	imgui: {
		name: "ImGui",
		submoduleDir: "modules/imgui", // single git submodule
		copyPatterns: [
			"im*.cpp",
			"im*.h",
			"backends/imgui_impl_dx11.*",
			"backends/imgui_impl_win32.*",
		],
		paramName: "imgui",
		apiIdentifierPatterns: ["IMGUI_API"],
	},
	/**
	 * ImExt module
	 */
	imext: {
		name: "ImExt",
		submoduleDir: "modules/extensions", // folder with git submodules
		copyPatterns: ["*.cpp", "*.h", "*.inl"],
		paramName: "ext",
		apiIdentifierPatterns: [
			"IMGUI_%(screaming_case_name)s_API",
			"IMEXT_%(screaming_case_name)s_API",
			"%(screaming_case_name)s_API",
			"IMEXT_API",
			"IMGUI_API",
		],
	},
}

const dllConfig = {
	/**
	 * DLL directory
	 *
	 * @type {String}
	 */
	baseDir: "src/dll/",
	/**
	 * Path to extension configs header relative to dll.baseDir
	 */
	configFile: "config.h",
	/**
	 * Directive name for any wrapper
	 */
	modifierDirective: "MOD",
}

const loggingConfig = {
	/**
	 * Whether to use colored output
	 *
	 */
	color: true,
	/**
	 * Whether to use rgb colored output
	 *
	 */
	colorUseRGB: true,

	/**
	 * Specific logTypes to ignore
	 *
	 * 'WP01'
	 * 'WP'
	 * '*'
	 * 'PARSER*'
	 *
	 * @See logging.logTypes
	 */
	ignore: [
		// Recommended way to organize (ASC order):  PARSER (DEBUG, WARNING, ...) etc.
	],
}

const gmConfig = {
	defaultProgram: "GameMakerStudio2",
	gmDataPath: path.join(
		process.env.PROGRAMDATA || "/var/lib",
		"GameMakerStudio2"
	), // e.g. C:/ProgramData/GameMakerStudio2/
	projectDir: "src/gm/ImGM/",
}

const parserConfig = {
	cpp: {
		tokenizerOptions: {
			keepSemi: true,
			addEOF: false,
			addNewline: true,
		},
	},
	jsdocfile: {
		tokenizerOptions: {
			keepSemi: false,
			addEOF: false,
			addNewline: true,
		},
	},
}

const jsdocConfig = {
	/**
	 * What tag to use for description
	 */
	descriptionTag: "@desc",
	/**
	 * What tag to use for function
	 */
	functionTag: "@function",
	/**
	 * What tag to use for params
	 */
	paramTag: "@param",
	/**
	 * What tag to use for returns
	 */
	returnTag: "@return",
	/**
	 * What tag to use for contexts
	 */
	contextTag: "@context",
	/**
	 * What comment type to use for the doclet itself
	 * 'single'     /// ...
	 * 'multi'      /**\n * ...\n...  \n *\/
	 */
	docletCommentType: "multi",
	/**
	 * Whether to write the arguments in the function tag line
	 */
	functionWriteArgs: false,
	/**
	 * Whether to set description to wrappers
	 */
	setDescriptions: true,
}

const styleConfig = {
	spacing: "\t",
}

export default {
	projectRoot: projectRoot,
	projectName: "ImGM",
	projectLink: "https://github.com/knno/ImGM",
	modules: modulesConfig,
	dll: dllConfig,
	logging: loggingConfig,
	gm: gmConfig,
	parser: parserConfig,
	jsdoc: jsdocConfig,
	style: styleConfig,
}

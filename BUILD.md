# 📦 Using ImGM for Development

## Build

#### Requirements

- Visual Studio
- NodeJS and NPM
- Premake

It is tested using:

- Visual Studio 2022
- NodeJS v24.5.0 - NPM v11.5.2
- Premake 5.0.0-beta2

### Build Steps

#### 1. Download the repository

```bash
git clone https://github.com/knno/ImGM
cd ImGM
```

##### 1.1. Pull submodules if needed

Use the following command to pull third-party dependencies (This is for ImGui and its extensions to work.)

- For ImGui only:

```bash
git submodule update --init modules/imgui
```

- For ImGui and its extensions:

```bash
git submodule update --init --recursive
```

#### 2. Install npm packages

```bash
npm install
```

#### 3. Initialize Dependencies using the Tools

The command syntax is `imgm modules:copy [--gm] [--imgui] [--ext <all|name>]`

##### 3.1. GM runtime files

GM runtime files initializing is optional since they are already included in git.

If you are using Git-bash:

```bash
source .bashrc
GM_RUNTIME=runtime-2024.14.0.251 imgm modules:copy --gm
```

If you are using Batch script:

```batch
set GM_RUNTIME=runtime-2024.14.0.251
npm run modules:copy -- --gm
```

As you can see, this selects a runtime as an environment variable to copy extension interface files from it.

##### 3.2. ImGui files

This step is required as it copies from third-party submodules (or generally from the modules folder) to the appropriate locations inside `src/dll/` folder.

```bash
imgm modules:copy --imgui --ext all
```

If you are using Batch script:

```batch
npm run modules:copy -- --imgui --ext all
```

#### 4. Build the DLL

##### 4.1. Regenerating the Visual Studio Project

You need to do this step if .cpp and header files or their locations renamed. or new files are added.
Using `premake5.lua` to generate your platform-specific project:

```bash
premake5 vs2022  # or gmake2, xcode, etc.
```

##### 4.2. Build ImGM files using Visual Studio

Open **dll.sln** solution file in Visual Studio and build the solution.
This compiles the DLL and places it in the GameMaker project sub-directory.

#### 5. Update GML files with the Tools

After getting that the extension was built using Visual Studio, you can use
the tools that allow automatic "detection and updating" of wrappers for all imgui and imgui extensions into the GameMaker project.

The command syntax is `imgm wrappers:gen <namespace> <headers-and-files...>`

Examples follow:

##### 5.1. Generate GML Wrappers

You can specify glob pattern `src/dll/imgui/wrappers/imgui_*_gm.cpp` for the C++ wrappers.

The following updates for ImGui (without extensions):

```bash
source .bashrc
imgm wrappers:gen imgui src/dll/imgui/internal/imgui.h src/dll/imgui/wrappers/imgui_*_gm.cpp
```

If you are using Batch script:

```bash
source .bashrc
imgm wrappers:gen imgui src/dll/imgui/internal/imgui.h src/dll/imgui/wrappers/imgui_*_gm.cpp
```

For more information check out the ImGM docs gh-pages website.

#### 6. Add an ImGui Extension or Write Wrappers

This is covered in the ImGM docs.

## Notes

- You must use a compiler which supports overlapping returns

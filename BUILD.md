# 📦 Using ImGM for Development

This guide will walk you through setting up ImGM locally on your machine so that you can build the ImGM DLL for yourself. This will allow you to maintain the codebase, add new features, and contribute to future development of this tool.

&nbsp;

## Required Tools

- [Visual Studio](https://visualstudio.microsoft.com/downloads/)
- [NodeJS and NPM](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [Premake](https://premake.github.io/)

This guide has been tested using:

- Visual Studio 2022
- NodeJS v24.5.0
- npm v11.5.2
- Premake 5.0.0-beta2

If you'd like to use another compiler, please be aware that the compiler must support overlapping returns.

For simplicity, it is recommended that you use the standard Powershell terminal to execute commands. You open a Powershell terminal in a folder by right clicking and choosing "Open in Terminal". However, you may want to use a Bash-like terminal (such as Git-Bash) and instruction are provided for Bash too.

&nbsp;

## Build Steps

### 1. Download the base repository

#### Option A - Using GitHub Desktop

Navigate to the landing page for the repository on GitHub and click the green "<> Code" button. Then select "Open with GitHub Desktop" to download a copy of the repository locally onto your machine.

#### Option B - Manual

Open a terminal and execute the following commands:

```bash
git clone https://github.com/knno/ImGM

cd ImGM
```

### 2. Pull submodules

The base ImGM repository contains only code particular to ImGM. You will need to copy Git submodules which contain the actual ImGui codebase using one of the following commands. If you're not sure what you need then it is recommended you copy everything from ImGui to avoid running into missing files later in the process.

These two commands can take a while to execute depending on the strength of your internet connection so some patience may be required.

#### Option A - ImGui and extensions:

```bash
git submodule update --init --recursive
```

#### Option B - ImGui core only:

```bash
git submodule update --init modules/imgui
```

### 3. Install npm packages

ImGM had some additional Node.js tooling that requires dependencies pulled from npm.

```bash
npm install
```

### 4. Initialize ImGui dependencies

We'll now copy C++ source files from the ImGui submodule into the Visual Studio project located at `/src/dll/`.

#### Using Powershell

```batch
npm run modules:copy -- --imgui --ext all
```

#### Using Bash

```bash
imgm modules:copy --imgui --ext all
```

### 5. Regenerating the Visual Studio Project

To keep Visual Studio up to date with any new files that have been added, we'll use Premake to construct a project file.

#### Using Powershell

If you don't have Premake previously installed on your machine then place `premake5.exe` into the root of the repo and execute this command:

```batch
.\premake5.exe vs2022
```

If Premake has already been installed and is in the PATH environment variable then you may execute the Bash command below.

#### Using Bash

```bash
premake5 vs2022
```

### 6. Build using Visual Studio

Open the `dll.sln` solution file in Visual Studio and build the solution. Note that the output directory will place the compiled DLL in the GameMaker project itself (`/src/gm/ImGM/extensions/ImGM/`).

### 7. Update GML files with the Tools

ImGM provides a tool to automatically generates GML code to interface with the DLL. The following commands use "module" handles to generate GML code for the GameMaker-facing external functions.

The command syntax for this tool is `imgm wrappers:gen <namespace>`. More information can be found [via ImGM's documentation](https://knno.github.io/ImGM/).

#### Using Powershell

```bash
npm run wrappers:gen imgui
```

#### Using Bash

```bash
imgm wrappers:gen imgui
```

### 8. Finished!

Open the GameMaker project and run it. You should see an example ImGui layout in the game window that is fully interactive.

&nbsp;

## Optional Build Steps

### Initialize GM runtime files

ImGM borrows some code from the current GameMaker runtime (at the time of writing, 2024.14.0.251) so it can interface with your game. In the future, a new GameMaker runtime may be released which breaks compatibility with the existing ImGM codebase. ImGM provides tooling to update its own copies automatically.

However, some modification of the GameMaker runtime files is necessary. Before copying over new GameMaker runtime code, please make a note of lines in the existing ImGM copies that have been annotated with `// NOTE: Modified for ImGM`.

Any at rate, this step sits between steps 4 and 5. After updating the GameMaker runtime code you should proceed with Premake to ensure the Visual Studio project is fully up to date.

#### Using Powershell

```batch
set GM_RUNTIME=runtime-2024.14.0.251

npm run modules:copy -- --gm
```

#### Using Bash

```bash
GM_RUNTIME=runtime-2024.14.0.251 imgm modules:copy --gm
```
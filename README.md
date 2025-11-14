# ImGM — ImGui for GameMaker
![Screenshot](./.github/Screenshot%202025-03-14%20043958.png)
![Build](https://github.com/knno/ImGM/actions/workflows/build.yml/badge.svg)
<!-- ![coverage](https://badgen.net/https/raw.githubusercontent.com/knno/ImGM/dev/extra/badges/coverage.json?icon=awesome) -->

**ImGM** is a wrapper extension that brings the power of [Dear ImGui](https://github.com/ocornut/imgui) to modern GameMaker projects. It enables immediate-mode GUI rendering with DLL integration, modular extension support, and rapid prototyping workflows.

> 🚀 Built for developers who want expressive UI, debug tools, and editor-like interfaces inside GameMaker.

---

## ✨ Features

- ✅ **Latest ImGui version** (auto-synced via submodule)
- 🧩 **Modular extension system** — easily wrap new ImGui features
- 🛠️ **DLL-backed performance** — native calls with minimal overhead
- 📦 **Auto-generated wrappers** — build-time report generation
- 🧪 **Example project included** — test and iterate quickly

---

## 📦 Installation

### For Usage

#### 1. Download the Package

Download the GameMaker package file(s) from the latest stable release.

#### 2. Import the Package to your GameMaker project

Click `import local package` in GameMaker IDE when your project is opened. Select the downloaded .yymps file.

> When the package is imported, you will have the extension added to your GameMaker project.

#### 3. Add the ImGM persistent controller object to the first room

Just add the persistent object `obj_ImGM` to a room, preferrably the first room.
This will enable you to call any extension function afterwards. As the object will manage the life-cycle automatically.

> Now you can call ImGui functions in your own code!

### For Development

#### 1. Download the repository

> 💡 If you clone instead and encounter LFS quota errors, use:
> ```bash
> GIT_LFS_SKIP_SMUDGE=1 git clone https://github.com/knno/ImGM.git
> cd ImGM
> git submodule update --init --recursive # or just: git submodule update --init modules/imgui
>
> ```
> Then manually replace for any missing or broken assets.

#### 2. Install npm

```bash
npm install
```

#### 3. Initialize using the Tools

```bash
source .bashrc
# imgm modules:copy [--gm] [--imgui] [--ext <all|name>]
GM_RUNTIME=runtime-2024.14.0.251 imgm modules:copy --gm --imgui
```

You can specify a runtime as an environment variable to copy extension interface files from it.

#### 4. Build the DLL

##### Regenerating the VS Project

Use `premake5.lua` to generate your platform-specific project:

```bash
premake5 vs2022  # or gmake2, xcode, etc.
```

##### Build using VS

Open dll.sln solution file in Visual Studio and build the solution.
This compiles the DLL and places it in the GameMaker project sub-directory.

#### 5. Generate Wrappers with the Tools

The tools allow for automatic "detection and updating" of wrappers for all imgui and imgui extensions into the project.

```bash
source .bashrc
# imgm wrappers:gen <namespace> <headers-and-files...>
imgm wrappers:gen imgui src/dll/imgui/internal/imgui.h src/dll/imgui/wrappers/imgui_*_gm.cpp # generate for ImGui
```

For more information check out the ImGM docs gh-pages website.

#### 4. Add An ImGui Extension or Write Wrappers

This is covered also in the ImGM docs.

---

## 🧪 Example Usage

```gml
ImGui.Begin("Hello");
ImGui.Text("Welcome to ImGM!");
ImGui.End();
```

## 📚 Documentation

See the [Docs](https://knno.github.io/ImGM) for:

- Full documentation of the project
- Full guides
- Build instructions
- Extension writing guide
- Explanation of tools
- How to debug
- Known issues ...

---

## 🛠️ Contributing

Pull requests welcome!
Check out the [CONTRIBUTING.md](CONTRIBUTING.md) and [Issues](https://github.com/knno/ImGM/issues/) for ideas.

---

## 📜 License

This project is licensed under MIT — free to use, modify, and distribute.

---

## 💬 Credits

Created by [Kenan Masri](https://github.com/knno)
Powered by Dear ImGui and the GameMaker community.

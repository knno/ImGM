# ImGM — ImGui for GameMaker
![Screenshot](./.github/Screenshot%202025-03-14%20043958.png)
![Build](https://github.com/knno/ImGM/actions/workflows/build.yml/badge.svg)
<!-- ![coverage](https://badgen.net/https/raw.githubusercontent.com/knno/ImGM/dev/extra/badges/coverage.json?icon=awesome) -->

### Background

> This repository is heavily inspired and based on [Nommiin's ImGui_GM](https://github.com/nommiin/imgui_gm)
>
> It was an inspiration for this to be extensible with ImGui extensions. So it needed refactoring.
>
> It is basically a GitHub fork of ImGui_GM with alot of changes and updates. While mostly keeping the same concept ideas, workflows, and alot of the source code including wrappers (with a little changes).
>
> Credits go to [Nommiin](https://github.com/nommiin) also for helping me out
>

## So what is this?

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

See [BUILD.md](BUILD.md)

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

Based on [Nommiin's ImGui_GM](https://github.com/nommiin/ImGui_GM)

Using [Omar's Dear ImGui library](https://github.com/ocornut/imgui)

Using various ImGui extensions by their authors

Powered by Dear ImGui and the GameMaker community.



> Please see the Credits section in ImGui_GM

# Installation

This guide explains how to install or update **ImGM** in your GameMaker project and optionally set up the supporting tooling.

---

## Installation

### Requirements
- **GameMaker** (latest stable version recommended)
- **ImGui DLL** (provided in the [GitHub repository](https://github.com/knno/ImGM) downloaded from the releases, or built separately)

Additionally, if you require development and tooling scripts:
- **NodeJS**
- The GitHub repository cloned

### Steps

#### 1. Download the Package

Download the GameMaker package file(s) from the latest stable release.

#### 2. Import the Package to your GameMaker project

Click `import local package` in GameMaker IDE when your project is opened. Select the downloaded .yymps file.

> When the package is imported, you will have the extension added to your GameMaker project.

#### 3. Add the ImGM persistent controller object to the first room

Just add the persistent object `obj_ImGM` to a room, preferrably the first room.
This will enable you to call any extension function afterwards. As the object will manage the life-cycle automatically.

---

## Updating

### Steps

#### 1. Backup your Project

Create a backup of your project, specifically the ImGM asset folder if you modified it manually.

#### 1. Download the Newer Package

Download the GameMaker package file(s) from the latest stable release.
Make sure to read the upgrading guide if there is in that release's notes.

#### 2. Import the Package to your GameMaker project

Click `import local package` in GameMaker IDE when your project is opened. Select the downloaded .yymps file.
- Tick the replace files with the newer files checkbox.
- Make sure you follow the upgrading guide in the release notes if any.

#### 3. Modify Files Again after Importing

If you have modified any files on your own, you should update them again, making sure it follows along any introduced coding changes.

## Notes
- Ensure DLLs are built for the correct platform and architecture (e.g. x64 vs x86).
- Coverage reports are written to markdown (.md) files in `docs/coverage/`.

---

## Next Steps
- Explore [Quick Examples](examples.md) to see wrappers in action.
- Review [Architecture](concept-architecture.md) to understand how layers fit together.

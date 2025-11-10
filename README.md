# ImGM


> ⚠️ Work-In-Progress!
> This readme and the project itself is considered W.I.P.
> Feel free to contribute

An ImGui wrapper for modern GameMaker.

[<!-- Screenshot -->](https://github.com/knno/ImGM/blob/dev/.github/Screenshot%202025-03-14%20043958.png)
![issues](https://badgen.net/github/open-issues/knno/ImGM)
![coverage](https://badgen.net/https/raw.githubusercontent.com/knno/ImGM/main/extra/badges/coverage.json?icon=awesome)

Check the [Wiki](https://github.com/knno/ImGM/wiki) for more info!

# Features
- Latest ImGui version
- Great workflow for development
  - Easily write wrappers for your desired ImGui extensions.
  - Generate reports automatically on building.
- Example included

# Installation

- Download the pre-built Windows packages for GameMaker from [Releases](https://github.com/knno/ImGM/releases).
- Or you can [build](#building) the source code! See below.

# Usage (GameMaker)

There are various ways to use the **ImGM** extension. Below we will see the basic and advance usage of ImGM.

## Prerequisites

Download and import the .yymps file.

## Basic Usage

1. Create a persistent object and call the essential functions in their respective events.
  - `ImGui.__Initialize()` in the create event
  - `ImGui.__NewFrame()` in any stepping event (suggested: *Begin Step*)
  - `ImGui.__EndFrame()` in any stepping event (suggested: *End Step* + *Room End*)
  - `ImGui.__Render()` in any rendering event (suggested: *Draw*)
  - `ImGui.__Draw()` in any draw event (suggested: *Draw GUI*)
  - `ImGui.__Shutdown()` in game end event

2. Write your UI code anywhere, make sure it is executed after `__NewFrame` and before `__EndFrame` calls.
  - Using the suggested *Begin Step* and *End Step* events makes it easier for UI code to be anywhere in *Step* events of objects.

3. Make sure you have read and understood the [Notes](#notes) section.

# Compatibility

## Platform

Currently, this extension makes heavy usage of the ability to pass a device handler and context to extensions... unfortunately, this functionality **is only avaliable for [DX11 targets](https://manual.yoyogames.com/index.htm#t=GameMaker_Language%2FGML_Reference%2FOS_And_Compiler%2Fos_get_info.htm)**.

# Coverage

Check out [`ImGM.gml`](https://github.com/knno/ImGM/blob/main/scripts/ImGui/ImGui.gml) to view all wrapper functions.
Check out [`COVERAGE.md`](https://github.com/knno/ImGM/blob/main/COVERAGE.md) for coverage report.

If there is anything missing, submit issues in this repository: [Click here to create an issue](https://github.com/knno/ImGM/issues).

# Notes

- Functions like `ImGui.Begin` may not return what you expect, see ["ImGuiReturnMask Usage"](https://github.com/knno/ImGM/wiki/ImGuiReturnMask-Usage) for more info

- Functions that accept an **array** of items as an argument (such as `ImGui.DragInt3`, `ImGui.SliderFloat2`, etc) will ***directly modify*** the given array. Keep this in mind when using them. Analogous functions that accept single elements (such as `ImGui.DrawInt`, `ImGui.SliderFloat`) ***will not*** make any changes directly to the value, and the return value should be used.

- Like the above, `ColorEdit4` and `ColorPicker4` take the GML class `ImColor` and mutates it directly; this is worth mentioning as `ColorEdit3` returns a BGR colour

# Special Thanks
- [Omar Cornut](https://github.com/ocornut/) for creating [Dear ImGui](https://github.com/ocornut/imgui)
- [rousr](https://rou.sr/) for creating [ImGuiGML](https://imguigml.rou.sr/) which inspired development of this
- [@nkrapivin](https://github.com/nkrapivin) for providing general assistance with `YYRunnerInterface` magic
- [@kraifpatrik](https://github.com/blueburncz/GMD3D11)'s GMD3D11 for serving as reference on how to retrieve textures from GameMaker
- [@nommiin](https://github.com/nommiin/ImGui_GM) original project as reference
- All direct or indirect contributors

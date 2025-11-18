# Coverage Reports

This document describes how **ImGM** tracks wrapper coverage and how contributors can use reports to identify gaps and progress.

---

## Overview

Coverage reporting ensures that ImGM maintains transparency about which ImGui functions are available in GameMaker.
Reports are automatically generated and stored in Markdown format for easy review.

---

## Purpose

- Show which ImGui API functions are wrapped and which are missing.
- Show which functions are native and which are custom.
- Help developers know where to add new wrappers.
- Ensure documenting the level of completeness.

---

## Report Structure

Coverage reports are organized by **namespace**:

- Each namespace here corresponds to ImGui or a specific ImGui extension.
- Reports include:
  - Name
  - Status (whether wrapped or just unknown status)
  - Source
  - Notes

Example table:

| Function        | Status  | Location            | Notes |
|-----------------|---------|---------------------|-------|
| `ImGui.Button`  | ✅     | imgui_widgets_gm.cpp | - |

---

## How it Works

While running the `wrappers:gen` command, meanwhile it will:

- Generate Markdown tables per namespace.
- Update the appropriate `docs/coverage/` markdown file(s) with the results.

---

## Next Steps
- Explore [Wrappers Manual](api-wrappers.md) for details on available functions.
- Review [Tooling & Scripts](concept-tooling.md) to understand automation.
- See [Release Workflow](release.md) for how coverage integrates into releases.

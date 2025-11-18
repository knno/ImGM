# Overview

ImGM is a modular integration layer that brings **ImGui** functionality into **GameMaker** projects.
This documentation will guide you how to use ImGM in your GameMaker project.
Additionally, it explains the architecture, setup, and workflows that make ImGM maintainable and contributor‑friendly.

---

## What is ImGM?

**ImGM** provides:
- A **DLL bridge** to ImGui’s native C++ implementation.
- **Wrapper functions** organized by namespace for clean GameMaker usage.
- **Tooling scripts** for coverage reporting, release packaging, and automation.

---

## Getting Started

- Install ImGM into your GameMaker project using the [Installation guide](installation.md).
- Explore [Quick Examples](examples.md) to see wrappers in action.
- Review the [Architecture](architecture.md) to understand how layers fit together.

---

## Architecture Layers

- **DLL Integration**: Native hooks into ImGui.
- **Tooling & Scripts**: Automation for coverage and release workflows.
- **GameMaker Bindings**: Idiomatic GML wrappers for ImGui functions.

---

## Release Workflow

ImGM uses automated scripts to:
- Initialize the development workflow and copy or update necessary files (`modules:copy`).
- Detect ImGui API functions and their wrappers in order to generate the extension (`wrappers:gen`).

---

## Contributing
Contributions are welcome! See [Contributing](https://github.com/knno/ImGM/blob/main/CONTRIBUTING.md) for coding style, PR workflow, and repo layout.

---

## Next Steps
- [Installation](installation.md)
- [Examples](examples.md)
- [Architecture](architecture.md)

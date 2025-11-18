# Tools

This document describes the tooling layer of **ImGM**.
Tooling scripts automate repetitive tasks, enforce consistency, and provide transparency for contributors.

---

## Overview

The tooling layer ensures that ImGM remains maintainable by automating:

- **Coverage reporting**: Tracks which ImGui functions are wrapped and documented.
- **Wrappers Generating**: Writes GML functions (Wrappers).
- **Requirements Updating**: Updating requirements such as GameMaker runtime easily.
- **More useful functions**: Functions can be written and added.

---

## Coverage Reporting

Coverage scripts generate Markdown tables per namespace:

- **Purpose**: Show which native ImGui functions are wrapped and supported in GameMaker and differentiate custom ones.
- **Output**: Tables in `docs/coverage/` markdown files with function names, status, and notes.
- **Usage**: Automatically happens when generating GML wrappers.

This helps contributors identify missing wrappers and track progress.

---

## Wrappers Generating

Writing GML scripts automate the creation and updating of GML functions in the provided project:

- **Purpose**: Write and update wrappers, docs, and coverages into their respective files.
- **Output**: Overwritten sections in specific GML files per namespace (e.g. ImGui.gml)
- **Usage**:
  ```bash
  imgm wrappers:gen ...
  ```

This ensures wrappers are reproducible with every execution.

---

## Design Principles

- **Automation first**: Reduce manual steps.
- **Customization**: Configs are available for specific needs.
- **Transparency**: Generate human-readable reports and changelogs.
- **Consistency**: Enforce predictable release workflows and reproducibility of results.
- **Extensibility**: Scripts can be adapted for future needs.

---

## Next Steps
- See [Coverage Reports](concept-coverage.md) for details on interpreting wrapper coverage.
- Explore [Release Workflow](release.md) for how tooling integrates with GitHub Releases.
- Review [Contributing](contributing.md) to learn how to use tooling in development.

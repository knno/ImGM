# Extensions — Adding a new extension (Git submodule)

This page shows recommended steps to add an extension to ImGM using a Git submodule, how extensions are expected to be laid out, and common commands/troubleshooting.

## Overview

Extensions live in the repository under `extensions/`. We prefer adding third‑party or local extension repositories as Git submodules so they remain versioned separately but trackable from the main repo.

## Recommended layout

Place your extension in only one of those options:
- `modules/extensions/<extension-name>` as git submodule.
- `src/dll/imext/<extension-name>` as content.

## Adding an extension (submodule)

From repository root:

1. Choose a path under `modules/extensions/`:

```bash
git submodule add <git-url> modules/extensions/<extension-name>
git commit -m "chore: initialize <ExtensionName> ext"
```

2. Push changes:

```bash
git push origin <branch>
```

3. On other clones or CI, initialize and fetch submodules:

```bash
# recommended when cloning
git clone --recurse-submodules <repo-url>

# if already cloned
git submodule update --init --recursive
```

4. To update the submodule to latest commit on its default branch:

```bash
cd modules/extensions/<extension-name>
git fetch origin
git checkout <branch-or-tag>
git pull
cd ../../..
git add modules/extensions/<extension-name>
git commit -m "chore: update <ExtensionName> ext to <branch/tag>"
git push
```

## Using relative URLs (optional)

If you want submodules to use relative paths (easier for forks), set the URL in `.gitmodules` to a relative URL or edit after adding:
```ini
[submodule "modules/extensions/example-extension"]
    path = modules/extensions/example-extension
    url = ../example-extension.git
```

## Removing a submodule

```bash
git submodule deinit -f -- modules/extensions/<extension-name>
rm -rf .git/modules/extensions/<extension-name>
git rm -f modules/extensions/<extension-name>
git commit -m "chore: remove <ExtensionName> ext"
git push
```

## Common workflows & tips

- CI: ensure `git submodule update --init --recursive` runs during setup.
- Windows: use Git Bash or ensure core.longpaths and symlink settings are configured if extensions include symlinks.
- Authentication: private submodules require the CI/runner to have access (SSH key or token).
- Locking versions: commit the submodule at the exact commit you want; the main repo records that commit.
- Inspect status:
```bash
git submodule status --recursive
```

## Troubleshooting
- "Submodule not initialized": run `git submodule update --init --recursive`.
- Wrong revision shown: run `git submodule update --recursive --remote` or update the submodule and commit the new pointer.
- Conflicts in `.gitmodules`: resolve like a normal merge conflict and ensure paths/urls are correct.

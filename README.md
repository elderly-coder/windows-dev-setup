<p align="center">
  <img src="assets/banner.webp" alt="windows-dev-setup banner: terminal window with gears and package boxes" width="100%">
</p>

<h1 align="center">windows-dev-setup</h1>

<p align="center">
  One script. Fresh Windows machine to working dev environment.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="MIT license">
  <img src="https://img.shields.io/badge/powershell-5.1%2B-blue?logo=powershell&logoColor=white" alt="PowerShell 5.1+">
  <img src="https://img.shields.io/badge/platform-Windows-lightgrey?logo=windows" alt="Windows">
</p>

## What it does

1. Installs core tooling via winget
2. Sets sane git defaults (main branch, rebase on pull, handy aliases)
3. Adds `which`, `ll`, and `mkcd` to your PowerShell profile

## Packages installed

| Package | Why |
|---|---|
| Git | Version control |
| Python 3.13 | Scripting |
| PowerShell 7 | A better shell |
| VS Code | Editor |
| FFmpeg | Media work |
| Windows Terminal | A better terminal |
| Notepad++ | Quick text edits |

## Run it

From an **elevated** PowerShell:

```powershell
.\setup.ps1
```

Skip the winget installs (git and profile config only):

```powershell
.\setup.ps1 -SkipWinget
```

> [!TIP]
> Edit the `$packages` list at the top of `setup.ps1` to match your own stack before running.

## Git defaults it sets

- `init.defaultBranch main`
- `pull.rebase true`
- `core.autocrlf true`
- Aliases: `st` (status), `co` (checkout), `lg` (graph log)

## License

[MIT](LICENSE)

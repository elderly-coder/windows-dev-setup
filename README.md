# windows-dev-setup

<!-- toc -->
- [windows-dev-setup](#windows-dev-setup)
  - [What it does](#what-it-does)
  - [Run it](#run-it)
<!-- /toc -->


One PowerShell script that bootstraps a fresh Windows dev machine.

## What it does

1. Installs core tooling via winget:
   Git, Python 3.13, PowerShell 7, VS Code, FFmpeg, Windows Terminal, Notepad++
2. Sets sane git defaults (main as default branch, rebase on pull, useful aliases)
3. Adds `which`, `ll`, and `mkcd` to your PowerShell profile

## Run it

From an **elevated** PowerShell:

```powershell
.\setup.ps1
```

Skip the winget installs (git/profile config only):

```powershell
.\setup.ps1 -SkipWinget
```

Edit the `$packages` list at the top of `setup.ps1` to match your own stack.

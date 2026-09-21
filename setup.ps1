<#
.SYNOPSIS
    Bootstraps a fresh Windows dev machine in one run.

.DESCRIPTION
    Installs core tooling via winget, sets sane git defaults,
    and drops a few quality-of-life aliases into the PowerShell profile.
    Run from an elevated PowerShell:  .\setup.ps1

.NOTES
    Edit the $packages list to taste before running.
#>
[CmdletBinding()]
param(
    [switch]$SkipWinget
)

$ErrorActionPreference = "Stop"

function Install-IfMissing {
    param([string]$Id, [string]$Name)
    $found = winget list --id $Id --exact --accept-source-agreements 2>$null |
        Select-String -Pattern $Id -SimpleMatch
    if ($found) {
        Write-Host "already installed: $Name" -ForegroundColor DarkGray
    } else {
        Write-Host "installing: $Name" -ForegroundColor Cyan
        winget install --id $Id --exact --silent `
            --accept-package-agreements --accept-source-agreements
    }
}

# --- packages: id = winget id, name = display label ---
$packages = @(
    @{ Id = "Git.Git";              Name = "Git" },
    @{ Id = "Python.Python.3.13";   Name = "Python 3.13" },
    @{ Id = "Microsoft.PowerShell"; Name = "PowerShell 7" },
    @{ Id = "Microsoft.VisualStudioCode"; Name = "VS Code" },
    @{ Id = "Gyan.FFmpeg";          Name = "FFmpeg" },
    @{ Id = "Microsoft.WindowsTerminal"; Name = "Windows Terminal" },
    @{ Id = "Notepad++.Notepad++";  Name = "Notepad++" }
)

if (-not $SkipWinget) {
    foreach ($p in $packages) { Install-IfMissing $p.Id $p.Name }
}

# --- git defaults ---
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.autocrlf true
git config --global alias.st "status -sb"
git config --global alias.co "checkout"
git config --global alias.lg "log --oneline --graph -15"
Write-Host "git defaults configured" -ForegroundColor Green

# --- profile aliases ---
$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory $profileDir | Out-Null }

$snippet = @'

# --- windows-dev-setup aliases ---
function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }
Set-Alias -Name ll -Value Get-ChildItem
function mkcd($dir) { New-Item -ItemType Directory $dir -Force | Out-Null; Set-Location $dir }
'@

$current = if (Test-Path $PROFILE) { Get-Content $PROFILE -Raw } else { "" }
if ($current -notmatch "windows-dev-setup aliases") {
    Add-Content $PROFILE $snippet
    Write-Host "aliases added to PowerShell profile" -ForegroundColor Green
} else {
    Write-Host "aliases already present in profile" -ForegroundColor DarkGray
}

Write-Host "`ndone. Restart your terminal to pick up PATH changes." -ForegroundColor Green

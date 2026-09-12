param(
    [string]$Path = "."
)

$ErrorActionPreference = "Continue"

function Write-Section {
    param([string]$Name)
    Write-Output ""
    Write-Output "## $Name"
}

$target = Resolve-Path -LiteralPath $Path -ErrorAction SilentlyContinue
if (-not $target) {
    Write-Output "PROJECT REALITY BASELINE"
    Write-Output "STATUS: BLOCKED"
    Write-Output "Repository path inaccessible: $Path"
    exit 1
}

Push-Location -LiteralPath $target.Path
try {
    Write-Output "PROJECT REALITY BASELINE"
    Write-Output "Path: $($target.Path)"

    $inside = git rev-parse --is-inside-work-tree 2>&1
    if ($LASTEXITCODE -ne 0 -or $inside -ne "true") {
        Write-Output "STATUS: BLOCKED"
        Write-Output "Not a Git repository or Git metadata is unavailable."
        Write-Output $inside
        exit 1
    }

    Write-Output "STATUS: OK"

    Write-Section "Repository Root"
    git rev-parse --show-toplevel

    Write-Section "Current Branch"
    git branch --show-current

    Write-Section "HEAD SHA"
    git rev-parse HEAD

    Write-Section "Recent Commit"
    git log -1 --oneline

    Write-Section "Git Status Short"
    git status --short

    Write-Section "Staged Files"
    git diff --cached --name-only

    Write-Section "Modified Files"
    git diff --name-only

    Write-Section "Untracked Files"
    git ls-files --others --exclude-standard
}
finally {
    Pop-Location
}

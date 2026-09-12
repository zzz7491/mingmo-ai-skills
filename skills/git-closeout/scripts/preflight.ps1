$ErrorActionPreference = 'Stop'

try {
    git rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) { throw 'not a Git worktree' }
} catch {
    Write-Error 'ERROR: current directory is not inside a Git worktree'
    exit 2
}

Write-Output '=== repository ==='
git rev-parse --show-toplevel
Write-Output '=== branch ==='
git branch --show-current
Write-Output '=== head ==='
git log -1 --oneline
Write-Output '=== status --short ==='
git status --short
Write-Output '=== unstaged diff --stat ==='
git diff --stat
Write-Output '=== staged diff --stat ==='
git diff --cached --stat

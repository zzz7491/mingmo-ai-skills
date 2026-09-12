#!/usr/bin/env bash
set -u

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: current directory is not inside a Git worktree" >&2
  exit 2
fi

echo '=== repository ==='
git rev-parse --show-toplevel

echo '=== branch ==='
git branch --show-current

echo '=== head ==='
git log -1 --oneline

echo '=== status --short ==='
git status --short

echo '=== unstaged diff --stat ==='
git diff --stat

echo '=== staged diff --stat ==='
git diff --cached --stat

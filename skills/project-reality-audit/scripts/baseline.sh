#!/usr/bin/env bash
set -u

target="${1:-.}"

section() {
  printf '\n## %s\n' "$1"
}

printf '%s\n' "PROJECT REALITY BASELINE"

if [ ! -d "$target" ]; then
  printf '%s\n' "STATUS: BLOCKED"
  printf '%s\n' "Repository path inaccessible: $target"
  exit 1
fi

cd "$target" || {
  printf '%s\n' "STATUS: BLOCKED"
  printf '%s\n' "Cannot enter path: $target"
  exit 1
}

printf '%s\n' "Path: $(pwd)"

inside="$(git rev-parse --is-inside-work-tree 2>&1)"
if [ "$?" -ne 0 ] || [ "$inside" != "true" ]; then
  printf '%s\n' "STATUS: BLOCKED"
  printf '%s\n' "Not a Git repository or Git metadata is unavailable."
  printf '%s\n' "$inside"
  exit 1
fi

printf '%s\n' "STATUS: OK"

section "Repository Root"
git rev-parse --show-toplevel

section "Current Branch"
git branch --show-current

section "HEAD SHA"
git rev-parse HEAD

section "Recent Commit"
git log -1 --oneline

section "Git Status Short"
git status --short

section "Staged Files"
git diff --cached --name-only

section "Modified Files"
git diff --name-only

section "Untracked Files"
git ls-files --others --exclude-standard

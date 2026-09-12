---
name: git-closeout
description: Platform-neutral Git phase closeout skill for verifying scope, tests, staged changes, commit integrity, and clean working-tree state. Use when a completed development phase is ready for Git acceptance and commit closeout.
version: 0.1.0
---

# Git Closeout

## Purpose
Safely close out an already-completed development phase in a Git repository. This skill verifies the repository state, authorized scope, validation results, staged changes, commit, and final working-tree state without silently expanding the task.

## When to use
Use this skill when the user asks to close out, finalize, accept, commit, or Git-close a completed development phase.

Do not use it to implement unfinished features, perform unrelated cleanup, deploy software, write production data, or push remote changes unless those actions are separately and explicitly authorized.

## Required inputs
Before any mutating Git action, determine:
- repository/worktree to operate on;
- current closeout scope (allowed files or clearly bounded change set);
- validation/test command(s), if the project defines them;
- intended commit message, or authorization to derive one from the accepted change.

If the authorized scope cannot be determined reliably, stop before staging or committing and request clarification.

## Operating principles
1. Facts before assumptions.
2. Inspect before mutating.
3. Stage only authorized changes.
4. Never hide unexpected modifications.
5. Validation failure blocks commit unless the user explicitly changes the acceptance decision.
6. A successful commit is not sufficient: verify the resulting commit and final working-tree state.
7. Do not broaden scope to fix incidental issues.

## Procedure

### Gate 1 — Preflight
Inspect:
- repository identity/path;
- current branch;
- `git status --short`;
- unstaged/staged diff summary;
- recent HEAD identity.

If the repository is not in the expected state, report the discrepancy before mutation.

### Gate 2 — Scope verification
Compare every changed/staged path against the authorized closeout scope.

If any path is outside scope:
- do not stage it;
- do not discard it;
- do not modify it;
- stop closeout if safe separation cannot be guaranteed;
- report the exact unexpected paths.

Read `references/acceptance-rules.md` for detailed acceptance rules.

### Gate 3 — Validation
Run only the validation commands appropriate to the accepted change and project instructions.

Record:
- command;
- exit status;
- concise result.

If validation fails, stop before commit and report the failure. Do not repair unrelated problems under this skill.

### Gate 4 — Staging
Stage only authorized paths.

Then inspect:
- `git status --short`;
- staged file list;
- `git diff --cached --check`;
- staged diff or staged diff summary as appropriate.

If staged content differs from the authorized scope, stop before commit.

### Gate 5 — Commit
Create exactly the authorized closeout commit.

Do not amend, rebase, reset, force, push, tag, deploy, or write remote/production data unless separately authorized.

### Gate 6 — Post-commit verification
Capture:
- `git log -1 --oneline`;
- full commit SHA;
- `git show --stat --oneline HEAD`;
- `git status --short`.

A non-clean final working tree is not automatically a failure if pre-existing or explicitly excluded changes remain, but they must be reported precisely. Never claim a clean tree when it is not clean.

## Safety boundaries
Read and obey `references/safety-boundaries.md` before mutating the repository.

## Output contract
Return a compact closeout report containing:

1. **Result** — PASS / BLOCKED / FAILED.
2. **Repository / branch**.
3. **Authorized scope**.
4. **Validation** — commands and PASS/FAIL.
5. **Commit** — message and SHA, if created.
6. **Final Git state** — clean or exact remaining paths.
7. **Blocked/remaining action** — only when applicable.

Never report an action as completed unless its result was actually observed.

# Scope Rules

## File Scope Semantics

- `AUTHORIZED FILE`: a file explicitly authorized for modification, creation, deletion, or rename as applicable.
- `CONFIRMED TOUCHPOINT`: verified relevant, active, or authoritative file/module/path without modification authorization.
- `LIKELY TOUCHPOINT`: possibly relevant file/module/path that has not been verified.
- `PROTECTED FILE / AREA`: forbidden or guarded by user instruction, baseline state, ownership, production risk, or scope.
- `PRE-EXISTING CHANGE`: dirty-tree content that existed before implementation work.
- `CURRENT-PHASE CHANGE`: change made during the authorized implementation phase.

Evidence that a file is relevant does not authorize modification.

## Directory-level Authorization

Directory authorization is valid only when explicit. It applies to files clearly inside the directory and only for the operation types authorized by the plan.

Directory authorization does not automatically allow:

- delete;
- rename;
- dependency installation;
- migration;
- generated artifacts;
- protected files;
- external writes;
- unrelated cleanup.

## New File Semantics

Creating a new file requires explicit authorization unless the plan explicitly authorizes creation in a bounded directory and the file is necessary for a listed task.

Generated files in the repository are new files and must be authorized and reported.

## Delete / Rename Rules

Delete and rename require explicit authorization. Edit authorization does not imply delete or rename authorization.

If a delete or rename appears necessary but was not authorized, STOP and request re-authorization.

## Pre-existing Change Protection

Do not stash, reset, clean, restore, discard, format, stage, commit, or rewrite pre-existing changes unless explicitly authorized for that exact purpose.

Work around pre-existing changes when possible. If authorized work cannot be separated safely, STOP.

## Protected Area Rules

Protected areas include:

- user-declared forbidden areas;
- files outside authorized scope;
- production configuration;
- migrations and schema writes unless authorized;
- dependency manifests/lockfiles unless authorized;
- external systems/databases;
- unrelated modules;
- legacy code unless explicitly in scope;
- pre-existing changes.

## Minimal Change Principle

Make the smallest change that satisfies the authorized task and acceptance criteria. Do not refactor, optimize, reformat, reorganize, upgrade dependencies, or fix unrelated issues without explicit authorization.

## Unexpected Finding Rule

New findings are recorded, not absorbed into scope. If they require out-of-scope work, report a scope deviation and STOP.

## Scope Deviation STOP

Use this format:

```text
SCOPE DEVIATION DETECTED

Deviation:
Evidence:
Why current plan is insufficient:
Affected scope:
Required authorization:
```

# Read-only Boundaries

Project Reality Audit is strictly read-only by default.

## Allowed by Default

Typical allowed operations:

- `git status`
- `git log`
- `git diff`
- `git show`
- `git ls-files`
- `git grep`
- `Get-ChildItem`
- `Get-Content`
- `Select-String`
- `find`
- `grep`
- `cat`

Read relevant source, configuration, schema, migration, package, test, and documentation files. Keep discovery proportional to the audit goal.

## Forbidden by Default

Do not run:

- `git add`
- `git commit`
- `git push`
- `git reset`
- `git checkout -- <file>`
- `git clean`
- `git stash`
- file write commands
- automatic formatting commands
- automatic lint-fix commands
- dependency installation commands
- migrations
- database write queries
- deployments
- environment mutation commands
- production mutation commands

Do not modify, stage, stash, reset, clean, or discard pre-existing dirty-tree changes.

## Tests

Tests are not automatically read-only. Treat test execution as forbidden until one of these is true:

- the test command is known to be safe and read-only in this repository;
- the user explicitly authorizes the test command and its expected side effects;
- the test is executed in an isolated disposable environment that cannot mutate the project or external systems.

If tests are not run because of side-effect risk, classify the runtime validation as `UNVERIFIED`, not failed.

## Tool Failures

If a preferred read-only tool is missing, use a safe substitute when available. Report the recovery as `TOOL FAILURE - RECOVERED`.

If no safe substitute can inspect required evidence, report `AUDIT BLOCKER`.

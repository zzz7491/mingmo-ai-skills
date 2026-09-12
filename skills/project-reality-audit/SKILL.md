---
name: project-reality-audit
description: Establish a read-only reality baseline for a software project before planning or implementation; use when facts, scope, drift, or current project state must be verified without making changes.
version: 0.1.0
---

# Project Reality Audit

## Purpose

Project Reality Audit establishes a trustworthy baseline of a project's current state before planning or implementation.

Core rule:

> Look at facts first, then make judgments. Audit only; do not implement.

Audit authorization is not implementation authorization. If the audit finds an obvious bug, broken flow, drift, or missing feature, record it as evidence and stop at the report. Do not fix it, stage it, commit it, push it, deploy it, migrate it, or enter the next development phase unless the user explicitly authorizes that separate phase.

This skill is technology-stack neutral. Do not assume Node.js, Cloudflare, PHP, Python, WeChat Mini Program, mobile, backend, frontend, monorepo, or any other framework unless the repository evidence supports it.

## Required References

Read these references when applying the skill:

- [references/evidence-rules.md](references/evidence-rules.md) for fact, inference, and anti-hallucination rules.
- [references/read-only-boundaries.md](references/read-only-boundaries.md) before running commands.
- [references/audit-statuses.md](references/audit-statuses.md) before classifying findings.

Use `scripts/baseline.ps1` or `scripts/baseline.sh` only when a deterministic read-only Git baseline helper is useful and appropriate for the current platform.

## Input Contract

Required:

- Repository / Project
- Audit Goal

Optional:

- Audit Scope
- Known Baseline
- Expected Behavior / Contract
- Relevant Files
- Validation Requirements
- Allowed Read-only Commands
- Forbidden Areas

User-provided Known Baseline is a claim to verify, not repository fact. If the user says a capability exists but the audit does not find supporting evidence, report:

```text
USER-PROVIDED BASELINE:
<claim>

AUDIT EVIDENCE:
NOT_FOUND in audited scope.

RESULT:
CONFLICT / REQUIRES VERIFICATION
```

If the required repository/project or audit goal is missing and cannot be inferred safely, stop before investigating beyond obvious metadata and ask for the missing input.

## Gate 0 - Authorization & Boundary

Confirm and record:

- Repository / Project
- Audit Goal
- Audit Scope
- Known Baseline, if provided
- Allowed read-only operations
- Forbidden areas

Do not treat broad tool access as broad authorization. Platform capabilities do not expand the user's scope. If the user authorizes audit only, remain read-only.

## Gate 1 - Repository Baseline

Inspect the repository identity and Git state when Git is available:

- repository root
- branch
- HEAD SHA
- recent commits
- `git status --short`
- staged files
- modified files
- untracked files
- pre-existing changes

Every dirty-tree item present before audit work must be labeled:

```text
PRE-EXISTING CHANGE
```

Do not modify, stash, reset, clean, checkout, format, stage, or otherwise handle pre-existing changes. Preserve Historical WIP.

If Git is unavailable and Git evidence is essential to the requested baseline, classify the audit as `BLOCKED`. If Git is not essential, continue and clearly mark Git baseline as `UNKNOWN`.

## Gate 2 - Project Discovery

Discover project reality progressively and proportionally to the audit goal:

- project structure
- language/framework evidence
- package/dependency system
- entry points
- configuration
- database/migrations
- tests
- scripts
- deployment configuration
- major modules

Do not read an entire large repository without a purpose. Prefer targeted file listings, search, manifests, and entry-point tracing. Use fast search tools such as `rg` when available; if unavailable, safely fall back to `git grep`, `Select-String`, `grep`, or `find` and distinguish recovered tool failure from an audit blocker.

## Gate 3 - Task-Relevant Investigation

Build an evidence chain around the Audit Goal. Trace relevant behavior across layers when applicable:

```text
entry point -> service -> repository/data layer -> schema/migration -> API -> frontend/client -> tests
```

Do not conclude that a feature is implemented from a filename alone. A file, adapter, config key, schema, or test is only evidence for what it actually shows. Verify whether it is connected to a runtime path when that matters to the audit goal.

## Gate 4 - Evidence Classification

Classify each material finding using only these fact states:

- `CONFIRMED`
- `PARTIAL`
- `NOT_FOUND`
- `UNKNOWN`
- `CONFLICT`

`NOT_FOUND` means "not found within the audited scope." It does not mean the thing does not exist anywhere.

Absence of evidence is not evidence of absence.

## Gate 5 - Risk & Conflict Analysis

Identify and separate:

- `CONFLICT`
- `RISK`
- `DRIFT`
- `LEGACY`
- `UNVERIFIED`

Pay particular attention to:

- dirty working tree
- documentation drift
- duplicate or dead implementation
- legacy implementation
- schema vs repository mismatch
- frontend vs API mismatch
- unapplied migration
- tests vs production behavior mismatch
- environment dependency
- unverified external service

Clearly separate `FACT` from `INFERENCE`. A fact has directly observed evidence. An inference is a reasoned conclusion based on evidence and must be labeled as such.

## Gate 6 - Reality Baseline Report + STOP

Produce the fixed report and stop. Do not automatically continue into implementation, remediation, Git closeout, deployment, migration, or the next stage.

The report may include a Recommended Next Stage, but it must end with:

```text
Awaiting explicit authorization.
```

## Output Contract

Always use these eight sections:

```text
PROJECT REALITY AUDIT

1. Audit Result
2. Repository Baseline
3. Scope & Method
4. Confirmed Reality
5. Gap Matrix
6. Conflicts & Risks
7. Evidence Index
8. Recommended Next Stage
```

Audit Result must be one of:

- `PASS` - enough evidence exists to establish a trustworthy baseline. This does not mean the project has no bugs.
- `PARTIAL` - only a partial trustworthy baseline can be established; `UNKNOWN`, uncovered scope, or unverifiable items remain.
- `BLOCKED` - key access, files, evidence, or permission is insufficient to form a reliable baseline.

Use a Gap Matrix when there are gaps:

```text
Area | Status | Evidence | Notes
```

Evidence Index should record practical traceability:

```text
Evidence ID
File
Line / Symbol, when practical
Observed Fact
```

## Failure / Blocking Contract

`BLOCKED` conditions include, but are not limited to:

- repository path inaccessible
- required files cannot be read
- Git evidence essential but unavailable
- critical scope inaccessible
- required external dependency cannot be inspected
- evidence too incomplete to support the requested baseline

When blocked, stop and report only:

- Blocker
- Evidence
- Impact
- Required Next Action

Do not expand permissions, change files, install dependencies, write credentials, or work around the boundary.

Tool failure is not automatically audit failure. If `rg` is missing and `git grep` or `Select-String` succeeds, classify as:

```text
TOOL FAILURE - RECOVERED
```

If no safe substitute can provide required evidence, classify as:

```text
AUDIT BLOCKER
```

## Read-only Contract

Default allowed operations are read-only inspection commands such as:

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

Reading source, config, schema, test, package, and documentation files is allowed when relevant to the audit scope.

Default forbidden operations:

- `git add`
- `git commit`
- `git push`
- `git reset`
- `git checkout -- <file>`
- `git clean`
- `git stash`
- file writes of any kind
- automatic formatting
- automatic lint fixes
- `npm install`, `pnpm install`, `pip install`, or similar dependency installation
- migration execution
- database `INSERT`, `UPDATE`, `DELETE`, or schema writes
- deployment
- environment variable mutation
- production system mutation

Running tests is not automatically read-only. Some tests write databases, snapshots, fixtures, coverage, caches, formatted files, or external service state. Run tests only when they are confirmed safe read-only within the audit boundary or when the user explicitly authorizes that validation.

## Adapter Notes

For platform-specific usage notes, see:

- [adapters/chatgpt.md](adapters/chatgpt.md)
- [adapters/opencode.md](adapters/opencode.md)
- [adapters/generic-agent.md](adapters/generic-agent.md)

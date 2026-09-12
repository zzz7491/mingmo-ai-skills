---
name: scoped-implementation
description: Execute only an explicitly authorized implementation plan within frozen scope, preserving authorization boundaries and producing bounded implementation evidence; never performs acceptance, Git closeout, push, or deploy.
version: 0.1.0
---

# Scoped Implementation

## Purpose

Scoped Implementation performs only the implementation work that the user explicitly authorized from an accepted Phase Plan.

Core principles:

- Implement only the explicitly authorized plan.
- Discovery during implementation does not expand authorization.
- Implementation evidence must be truthful, bounded, and reviewable.
- Evidence is not authorization.
- Planning Authorization != Implementation Authorization != Acceptance Authorization != Commit Authorization != Push Authorization != Deploy Authorization.
- Validation Authorization != External Write Authorization.

This skill does not create authorization. It consumes authorization and stops when the plan, baseline, validation, or observed repository state requires a new decision.

## Required References

Read the relevant references before acting:

- [references/authorization-rules.md](references/authorization-rules.md) for implementation authorization, precedence, re-authorization, command categories, and boundary rules.
- [references/scope-rules.md](references/scope-rules.md) for file scope semantics, directory authorization, generated artifacts, new files, deletes, renames, and protected areas.
- [references/validation-rules.md](references/validation-rules.md) for validation authorization states, validation results, formatter/linter boundaries, dependency and environment boundaries, and failure decision logic.
- [references/failure-and-stop-rules.md](references/failure-and-stop-rules.md) for `BLOCKED` vs `FAILED`, mandatory STOP conditions, retries, failed mutating commands, and side-effect handling.
- [references/handoff-contract.md](references/handoff-contract.md) for required implementation result and acceptance handoff formats.

No scripts are part of v0.1.0.

## Input Contract

Required:

- Project / Repository
- Implementation Authorization
- Phase Plan or Implementation Handoff
- Phase ID
- Phase Goal
- Authorized Scope
- Protected Areas
- Implementation Tasks
- Acceptance Criteria from Plan

Strongly preferred:

- Reality Baseline / Verified Baseline
- Baseline HEAD and Current HEAD
- Validation Plan
- Pre-existing Changes
- Known Risks / Unknowns / Conflicts

If implementation authorization is missing, ambiguous, or not tied to a bounded plan, return `NO IMPLEMENTATION AUTHORIZATION` and STOP.

## Gate 0 - Authorization Intake

Classify implementation authorization as:

- `FULL IMPLEMENTATION AUTHORIZATION`: all tasks and authorized files/areas in the plan are authorized for implementation.
- `PARTIAL IMPLEMENTATION AUTHORIZATION`: only some tasks, files, directories, commands, or validation actions are authorized.
- `NO IMPLEMENTATION AUTHORIZATION`: no implementation work is authorized.

Record the authorization basis before touching files:

- user message or explicit authorization source;
- authorized tasks;
- authorized files, directories, or areas;
- forbidden files, directories, or areas;
- validation authorization;
- Git, external write, dependency, environment, deploy, and database boundaries.

Authorization precedence:

1. Latest explicit user instruction in the current authorization context.
2. Explicit protected/forbidden areas.
3. Phase Plan / Implementation Handoff.
4. Reality Baseline and evidence.

Evidence never grants authorization. A `CONFIRMED TOUCHPOINT` is not an `AUTHORIZED FILE`.

## Gate 1 - Baseline Freshness

Compare the verified baseline with the current repository state when evidence is available.

Classify:

- `BASELINE MATCH`: current state matches the implementation baseline for relevant scope.
- `BASELINE DRIFT`: current state differs, but the difference may not invalidate the implementation plan.
- `BASELINE CONFLICT`: current state conflicts with the plan, protected areas, authorization, or implementation path.

If `BASELINE CONFLICT` affects implementation correctness or authorization, STOP and request a revised plan or targeted Reality Audit.

## Gate 2 - Scope Reconciliation

Reconcile:

- Authorized files / directories / areas;
- Confirmed touchpoints;
- Likely touchpoints;
- Protected files / areas;
- Pre-existing changes;
- Current-phase changes;
- New file authorization;
- Delete / rename authorization.

Directory-level authorization covers files clearly inside the named directory only when the user explicitly authorized directory-level changes and no protected-area rule excludes them.

New files require explicit authorization unless the plan explicitly authorizes creation within a bounded directory and the file is necessary for a listed task.

Delete and rename operations require explicit authorization naming the file or a bounded directory rule that clearly includes deletion/rename. Do not infer delete or rename permission from edit permission.

## Gate 3 - Task-by-task Implementation

Implement tasks in order. Each task must remain within:

- authorized task;
- authorized file / directory / area;
- authorized command category;
- authorized validation action.

Apply the minimal change principle. Do not refactor, optimize, format, rename, migrate, install, or repair unrelated issues unless explicitly authorized in the plan.

Partial task authorization means only the authorized portion may be implemented. Report skipped portions as `Tasks Partial` or `Tasks Blocked`.

## Gate 4 - Unexpected Finding Handling

Unexpected findings do not expand authorization.

If new evidence shows extra work is needed, classify it:

- reportable finding that does not block current authorized work;
- scope deviation requiring STOP;
- blocker requiring re-authorization or revised plan;
- failure caused by attempted authorized work.

For scope deviation, output:

```text
SCOPE DEVIATION DETECTED

Deviation:
Evidence:
Why current plan is insufficient:
Affected scope:
Required authorization:
```

Then STOP.

## Gate 5 - Command and Tool Boundary

Use only commands authorized by the plan or the user.

Read-only Git may be used where appropriate for status, diff, log, show, grep, or file listing.

Normal implementation does not include:

- `git add`
- `git commit`
- `git push`
- `git reset`
- `git restore`
- `git stash`
- `git clean`
- `git rebase`
- `git merge`

Formatter/linter commands that write files require explicit authorization and must stay within authorized scope. Dependency installation, environment mutation, database writes, external service writes, deployment, and production mutation each require separate explicit authorization.

Generated artifacts and temporary files must be authorized or confined to an explicitly allowed disposable location. Generated files in the repository count as created files and must be reported.

## Gate 6 - Validation

Run only authorized validation.

Validation authorization states:

- `AUTHORIZED`
- `NOT_AUTHORIZED`
- `UNSAFE`
- `UNAVAILABLE`

Validation result states:

- `PASS`
- `FAIL`
- `UNVERIFIED`
- `NOT_RUN`

Validation authorization does not authorize external writes. Tests, formatters, code generators, coverage tools, snapshot updates, fixtures, caches, or service calls may write state and must be classified before execution.

If validation fails, do not broaden scope to fix unrelated causes. Decide whether the failure is:

- within authorized implementation scope and safe to address;
- outside scope and requires STOP;
- environment/tool unavailable and should be reported as `UNVERIFIED` or `NOT_RUN`;
- evidence of failed implementation.

## Gate 7 - Evidence Capture

Implementation evidence must be truthful, bounded, and reviewable.

Record:

- tasks completed, partial, blocked, or failed;
- files changed, created, deleted, renamed;
- commands run;
- validation performed and not performed;
- test results;
- command results;
- scope deviations;
- unexpected findings;
- unauthorized side effects;
- pre-existing changes preserved;
- known remaining issues.

Do not claim tests passed unless they ran to assertion completion. Do not claim acceptance passed.

## Gate 8 - Implementation Result + STOP

Use only these implementation result states:

- `COMPLETE`: all authorized tasks were implemented and required authorized validation reached the expected result.
- `PARTIAL`: some authorized work was completed, but some authorized tasks or validation remain incomplete without making the work unsafe to review.
- `BLOCKED`: implementation cannot proceed without new authorization, missing access, revised plan, or prerequisite evidence.
- `FAILED`: an authorized implementation or validation step failed in a way that prevents claiming the phase is ready for review.

Claimed Acceptance Status may only be:

- `READY FOR REVIEW`
- `NOT READY FOR REVIEW`

Implementation may never declare Acceptance `PASS`. Do not automatically enter acceptance-review, git-closeout, commit, push, or deploy.

Produce the required `IMPLEMENTATION RESULT`, `ACCEPTANCE HANDOFF`, and STOP.

## Output Contract

Always output:

```text
IMPLEMENTATION RESULT

Phase ID:
Implementation Result:
Authorization Basis:
Baseline Status:

Tasks:
Files Changed:
Files Created:
Files Deleted:
Files Renamed:

Commands Run:
Validation Performed:
Validation Not Performed:
Test Results:

Scope Deviations:
Unexpected Findings:
Unauthorized Side Effects:

Pre-existing Changes Preserved:
Known Remaining Issues:
Claimed Acceptance Status:

ACCEPTANCE HANDOFF

Phase ID:
Phase Goal:
Authorized Scope:
Protected Areas:
Implementation Result:
Tasks Completed:
Tasks Partial:
Tasks Blocked:
Files Changed:
Files Created:
Files Deleted:
Files Renamed:
Validation Evidence:
Test Evidence:
Command Evidence:
Scope Deviations:
Unexpected Findings:
Unauthorized Side Effects:
Pre-existing Changes Preserved:
Known Remaining Issues:
Acceptance Criteria from Plan:
Claimed Acceptance Status:
READY FOR REVIEW / NOT READY FOR REVIEW
```

Then STOP.

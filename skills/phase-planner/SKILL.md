---
name: phase-planner
description: Convert a verified project reality baseline and user goal into a bounded, acceptable, and authorization-ready implementation phase plan; planning only, never implementation.
version: 0.1.0
---

# Phase Planner

## Purpose

Phase Planner converts verified project reality into a clear, bounded, executable, acceptable, and authorizable next implementation phase.

Core rules:

> Plan from evidence, not assumptions.

Planning authorization is not implementation authorization. Even when `Planning Result = READY`, do not modify code, create project files, run unauthorized validation, install dependencies, perform Git closeout, commit, push, deploy, run migrations, write databases, mutate production, or start implementation.

This skill answers:

```text
Based on the current verified reality, what should the next phase do, what must it not do, how should it be implemented, and how will completion be proven?
```

It does not perform implementation.

## Required References

Read the relevant references before producing a phase plan:

- [references/planning-statuses.md](references/planning-statuses.md) for `READY`, `PARTIAL`, `BLOCKED`, and upstream status propagation.
- [references/scope-rules.md](references/scope-rules.md) for scope, touchpoints, protected areas, scope conflict, and deviation handling.
- [references/handoff-contract.md](references/handoff-contract.md) for pipeline handoffs and authorization chain rules.
- [references/acceptance-design.md](references/acceptance-design.md) for acceptance criteria and validation-plan design.

No scripts are required for this skill. It is a planning and handoff skill, not an execution helper.

## Responsibility Boundary

Responsible for:

- reading a verified Reality Baseline;
- understanding the user's current goal;
- defining a Phase Goal;
- defining `IN SCOPE`;
- defining `OUT OF SCOPE`;
- defining Authorized Touchpoints;
- defining Protected Areas;
- analyzing dependencies and risks;
- designing implementation tasks;
- defining acceptance criteria;
- defining a validation plan;
- outputting an Implementation Handoff;
- outputting a Recommended Next Action;
- STOP.

Not responsible for:

- code modification;
- project file creation;
- bug fixing;
- `git add`, `git commit`, `git push`;
- dependency installation;
- migrations;
- deployment;
- database writes;
- production mutation;
- automatic implementation;
- scope expansion;
- converting `UNKNOWN` into `CONFIRMED`.

## Input Contract

Required:

- Project / Repository
- Planning Goal

Strongly preferred:

- Reality Baseline

Optional:

- Current Phase
- Known Baseline
- User Constraints
- Authorized Scope
- Forbidden Areas
- Protected Areas
- Expected Outcome
- Validation Requirements
- Existing Acceptance Criteria
- Relevant Files / Modules
- Environment Constraints

Always distinguish:

- `VERIFIED FACT`: supported by a trusted baseline or newly verified evidence.
- `USER CONSTRAINT`: a user instruction that governs planning.
- `USER CLAIM`: a factual assertion from the user that is not automatically verified.
- `UNKNOWN`: missing or insufficient evidence.

Example:

```text
USER CONSTRAINT:
SMS must not be implemented in this phase.

USER CLAIM:
SMS adapter already exists.
```

The first is a planning constraint. The second needs evidence before it can become a verified fact.

## Gate 0 - Planning Authorization

Confirm:

- Project / Repository
- Planning Goal
- Current Phase, if provided
- Known constraints
- Forbidden Areas
- Available Reality Baseline

Record:

```text
Planning requested.
Implementation not authorized.
```

Broad tool permission does not imply implementation authorization.

## Gate 1 - Baseline Intake

Prefer consuming a Project Reality Audit Reality Baseline. Also allowed as inputs:

- accepted prior phase result;
- Git baseline;
- user constraints;
- user claims.

Classify each baseline item as `VERIFIED FACT`, `USER CONSTRAINT`, `USER CLAIM`, or `UNKNOWN`.

If a Reality Audit classified a fact as `CONFIRMED`, `PARTIAL`, `NOT_FOUND in audited scope`, `UNKNOWN`, or `CONFLICT`, preserve that status unless new verified evidence supports an update. If status changes, write:

```text
Status updated based on new verified evidence.
```

If no credible baseline exists, planning confidence is `LIMITED`. Return `BLOCKED` when critical facts are too weak and continuing would require guessing.

## Gate 2 - Goal Normalization

Convert the user's natural-language goal into a single-phase goal that is:

- clear;
- bounded;
- acceptable;
- consistent with the baseline;
- free of hidden extra features.

Do not accept vague goals such as:

- "optimize it";
- "complete the whole thing";
- "clean up related code";
- "refactor everything relevant";
- "fix whatever else appears".

Produce a specific `Phase Goal`.

## Gate 3 - Scope Definition

Every phase plan must define all of:

- `IN SCOPE`
- `OUT OF SCOPE`
- `AUTHORIZED TOUCHPOINTS`
- `PROTECTED AREAS`

Evidence is not authorization. Evidence that a file is relevant does not authorize modification.

Use `AUTHORIZED FILES` only when the user explicitly authorized those specific files or when the files clearly fall inside a user-authorized implementation scope.

Use `CONFIRMED TOUCHPOINT` when verified evidence shows a file, module, route, or service is relevant, active, or authoritative, but modification authorization has not been granted.

Use `LIKELY TOUCHPOINT` when a file, module, route, or service may be relevant but has not been verified.

Do not infer modification permission from `CONFIRMED`, verified evidence, active runtime path, or authoritative implementation path.

If there are no special out-of-scope items beyond global safety boundaries, write:

```text
No additional out-of-scope items identified beyond global safety boundaries.
```

## Gate 4 - Dependency & Risk Analysis

Analyze:

- prerequisites;
- dependencies;
- environment assumptions;
- schema dependencies;
- external service dependencies;
- known conflicts;
- pre-existing changes;
- migration risk;
- compatibility risk;
- validation/test risk.

Separate `FACT`, `INFERENCE`, and `PROPOSAL`. Do not present an inference as a fact.

## Gate 5 - Implementation Task Design

Split the phase into minimal ordered tasks. Each task must use:

```text
Task N

Objective:
Allowed Area:
Expected Change:
Completion Signal:
```

Tasks must not expand scope. Never include:

```text
Fix any other issues discovered while working.
```

Newly discovered scope is reported, not automatically absorbed.

## Gate 6 - Acceptance Design

Design completion standards before implementation starts.

Include:

- Acceptance Criteria;
- Validation Method;
- Expected Results;
- Non-regression Checks;
- Forbidden Side Effects.

Acceptance criteria must be observable, specific, bounded, and evidence-producing. Avoid vague criteria such as "works correctly", "improved", "cleaner", or "better".

## Gate 7 - Phase Plan + STOP

Output the fixed phase plan and stop. Do not automatically:

- implement;
- modify code;
- create project files;
- run unauthorized validation;
- run Git Closeout;
- commit;
- push;
- deploy;
- migrate.

End with:

```text
Awaiting explicit implementation authorization.
```

## Planning Result

Use only:

- `READY`: enough baseline, scope, dependency, and acceptance information exists to form a trustworthy Implementation Plan.
- `PARTIAL`: a partially trustworthy plan can be formed, but non-blocking `UNKNOWN` or unverified items remain.
- `BLOCKED`: key facts, scope, permission, or dependency information is missing; continuing would force guessing.

`READY` does not authorize implementation.

## Output Contract

Always output:

```text
PHASE PLAN

1. Planning Result
2. Phase ID & Phase Goal
3. Verified Baseline
4. In Scope
5. Out of Scope
6. Dependencies & Risks
7. Implementation Tasks
8. Acceptance Criteria
9. Validation Plan
10. Authorization Boundary

IMPLEMENTATION HANDOFF

Phase ID:
Phase Goal:
Verified Baseline:
In Scope:
Out of Scope:
Authorized Touchpoints:
Protected Areas:
Implementation Tasks:
Acceptance Criteria:
Validation Plan:
Known Risks:
Known Unknowns:
Known Conflicts:
Pre-existing Changes:
Implementation Authorization:
NOT GRANTED

Recommended Next Action:

Awaiting explicit implementation authorization.
```

## Verified Baseline

Only include evidence-supported states:

- `CONFIRMED`
- `PARTIAL`
- `NOT_FOUND in audited scope`
- `UNKNOWN`
- `CONFLICT`

Absence of evidence is not evidence of absence. Use `NOT_FOUND in audited scope` for inherited Reality Audit findings that mean the item was not found within the audited scope.

Do not rerun a full Reality Audit inside this skill. If critical facts are missing, recommend:

```text
Recommended prerequisite:
Run targeted Project Reality Audit.
```

Then return `PARTIAL` or `BLOCKED` depending on impact.

## Scope Rules

Every plan must define:

- `IN SCOPE`
- `OUT OF SCOPE`
- `AUTHORIZED TOUCHPOINTS`
- `PROTECTED AREAS`

Protected Areas should account for:

- `PRE-EXISTING CHANGE`;
- unrelated modules;
- legacy implementation;
- production configuration;
- migrations;
- user-declared forbidden areas.

If a user goal requires a forbidden, protected, or unauthorized area, report:

```text
SCOPE CONFLICT

Required implementation touches a protected or forbidden area.

Planning Result:
BLOCKED
```

## Pre-existing Changes

Preserve `PRE-EXISTING CHANGE` from the baseline. Do not plan to stash, reset, clean, discard, commit unrelated WIP, or format unrelated files.

Plan around pre-existing changes where possible. If impossible, report a scope conflict and stop.

## Implementation Task Contract

Each task must include:

```text
Task N

Objective:
Allowed Area:
Expected Change:
Completion Signal:
```

Do not include unbounded tasks such as "fix discovered issues", "optimize related code", or "clean up all relevant files".

## Acceptance Design

Acceptance Criteria must be:

- observable;
- specific;
- bounded;
- evidence-producing.

Examples:

- target runtime path reaches the verified adapter;
- existing behavior remains unchanged;
- no SMS implementation is introduced;
- no files outside authorized scope are modified.

## Validation Plan

The planner designs validation; it does not execute it.

Classify validation as:

- `REQUIRED VALIDATION`
- `OPTIONAL VALIDATION`
- `NOT AUTHORIZED`

Record when practical:

- Method / Command
- Expected Result
- Side-effect Risk
- Authorization Requirement

Test existence does not mean tests pass. A test plan does not authorize the planner to run tests.

## Failure / Blocking Rules

Return `BLOCKED` when any of these apply:

- Project / Repository cannot be determined;
- Planning Goal cannot be determined;
- core implementation path is `UNKNOWN`;
- authoritative implementation path has `CONFLICT`;
- user goal conflicts with forbidden scope;
- required area is not authorized;
- key external contract is unknown and directly determines implementation;
- Reality Baseline is too stale to plan reliably;
- acceptance condition cannot be verified.

When blocked, output:

```text
PLANNING RESULT: BLOCKED

Blocker:
Evidence:
Impact:
Required Prerequisite:
```

Then stop.

## Authorization Boundary

Authorization never propagates automatically:

```text
Audit Authorization
!= Planning Authorization
!= Implementation Authorization
!= Acceptance Authorization
!= Commit Authorization
!= Push Authorization
!= Deploy Authorization
```

Each stage requires separate authorization.

## Phase Identity

Every plan must have a `Phase ID`. Prefer the user's existing ID, such as `P0-A`, `P0-B`, `P0-C`, or `Phase 1.28`. If none exists, use a concise descriptive ID such as `notification-runtime-wiring`.

Use the same Phase ID across planning, implementation, acceptance, and Git closeout.

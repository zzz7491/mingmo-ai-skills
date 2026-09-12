---
name: acceptance-review
description: Independently verify an implemented phase against its authorized acceptance contract, produce acceptance judgment and handoffs, and never repair, stage, commit, push, or deploy.
version: 0.1.0
---

# Acceptance Review

## Purpose

Acceptance Review independently verifies whether a scoped implementation satisfies the authorized phase contract. It reviews evidence, revalidates relevant repository reality, checks scope/provenance, and produces either a Git Closeout handoff or an implementation repair handoff.

Core principles:

- Acceptance must be independently verified, not inherited from implementation.
- Implementation claims are evidence inputs, not acceptance facts.
- Acceptance evaluates the authorized phase, not unrelated project quality.
- Unverified criteria cannot be silently treated as passed.
- Acceptance verifies the contract; it does not rewrite the contract.
- Observed reality overrides implementation claims.
- State is not provenance.
- Test existence != Test execution != Test success.
- Implementation status is an input, never the acceptance verdict.
- Git Closeout Readiness != Commit Authorization.

Acceptance Review itself never modifies implementation, stages files, commits, pushes, deploys, repairs code, rewrites history, or automatically enters Git Closeout.

## Required References

Read the relevant references before reviewing:

- [references/acceptance-rules.md](references/acceptance-rules.md) for authorization, gates, original criteria authority, results, STOP contract, and stage boundaries.
- [references/evidence-rules.md](references/evidence-rules.md) for evidence semantics, criterion review states, false-positive and false-negative protections.
- [references/provenance-rules.md](references/provenance-rules.md) for source-of-truth hierarchy, provenance states, baseline freshness, scope integrity, and pre-existing change handling.
- [references/validation-replay.md](references/validation-replay.md) for replay policy, validation authorization, and test evidence.
- [references/failure-and-repair.md](references/failure-and-repair.md) for non-PASS repair routing and implementation repair handoff.
- [references/handoff-contract.md](references/handoff-contract.md) for final output formats and Git Closeout handoff.

No scripts are part of v0.1.0.

## Input Contract

Required:

- Project / Repository
- Phase ID
- Authorized Phase Plan
- Acceptance Handoff
- Explicit Acceptance Review Authorization

The review must be able to read and compare:

- Phase Goal
- Authorized Scope
- Protected Areas
- Acceptance Criteria
- Implementation Result
- Tasks Completed / Partial / Blocked
- Files Changed / Created / Deleted / Renamed
- Validation Evidence
- Test Evidence
- Command Evidence
- Scope Deviations
- Unexpected Findings
- Unauthorized Side Effects
- Pre-existing Changes Preserved
- Known Remaining Issues
- Claimed Acceptance Status

`READY FOR REVIEW` is not Acceptance Authorization. Implementation Authorization != Acceptance Authorization != Commit Authorization != Push Authorization != Deploy Authorization. Acceptance Authorization != Validation Mutation Authorization.

## Gate 0 - Acceptance Authorization

Confirm explicit Acceptance Review Authorization and boundaries:

- repository/project;
- Phase ID;
- authorized source material;
- accepted validation replay permissions;
- forbidden mutation;
- Git, push, deploy, external write, and repair boundaries.

If authorization is missing or ambiguous, return `BLOCKED` and STOP.

## Gate 1 - Handoff & Phase Identity Check

Compare Phase ID, Phase Goal, Authorized Scope, Protected Areas, Acceptance Criteria, baseline facts, and files changed across the Phase Plan, Acceptance Handoff, and implementation evidence.

If they conflict materially, output `HANDOFF CONFLICT` or `ACCEPTANCE CONTRACT CONFLICT`, return `BLOCKED`, and STOP.

Original Acceptance Criteria authority:

```text
Latest explicit user amendment
> Original authorized Acceptance Criteria
> Acceptance Handoff copy
> Implementation claims
```

Do not relax, delete, rewrite, add reviewer preference, or change required criteria into optional criteria.

## Gate 2 - Acceptance Baseline Revalidation

Revalidate the review baseline using read-only inspection where authorized.

Classify:

- `ACCEPTANCE BASELINE MATCH`
- `ACCEPTANCE BASELINE DRIFT`
- `ACCEPTANCE BASELINE CONFLICT`

At minimum consider repository, branch, HEAD, working tree, target paths, accepted scope, pre-existing changes, and post-implementation changes.

If a target file changed after implementation and provenance matters:

```text
POST-IMPLEMENTATION CHANGE DETECTED
ACCEPTANCE BASELINE CONFLICT
Acceptance Result = BLOCKED
```

Do not automatically classify that as implementation `FAILED`.

## Gate 3 - Scope Integrity Review

Compare Authorized Scope vs Observed Changed Scope.

Classify changed items:

- `AUTHORIZED CHANGE`
- `PRE-EXISTING CHANGE`
- `UNRELATED CHANGE`
- `UNEXPLAINED CHANGE`
- `SCOPE VIOLATION`

Check Protected Areas. A changed file outside authorized scope is not automatically an implementation violation; first determine provenance. If current implementation clearly modified a protected area, Acceptance is usually `FAILED`.

## Gate 4 - Implementation Evidence Review

Treat Implementation Result, Claimed Acceptance Status, validation evidence, test evidence, command evidence, and file lists as evidence inputs.

Implementation `COMPLETE` is never Acceptance `PASS`. Implementation claims must be checked against observed repository reality and acceptance criteria.

Record premature Git writes, unauthorized external side effects, or pre-existing change violations if found.

## Gate 5 - Acceptance Criteria Verification

Review every criterion independently using:

```text
Criterion ID:
Requirement:
Type:
Status:
Evidence:
Evidence Strength:
Independent Replay:
Notes:
```

Criterion statuses:

- `PASS`
- `FAIL`
- `UNVERIFIED`
- `NOT_APPLICABLE`

Criterion types:

- `EXACT`
- `BEHAVIORAL`
- `STRUCTURAL`
- `NEGATIVE`
- `EVIDENTIARY`

Negative criteria must be verified where applicable, including no files outside scope modified, no commit occurred, and protected areas unchanged.

## Gate 6 - Validation / Test Evidence Review

Choose a validation replay policy:

- `REUSE EVIDENCE`
- `REPLAY REQUIRED`
- `REPLAY OPTIONAL`
- `REPLAY NOT AUTHORIZED`
- `REPLAY UNAVAILABLE`

Independent review does not mean blindly repeating every command; it means independently establishing sufficient evidence.

Acceptance Validation Authorization states:

- `GRANTED`
- `LIMITED`
- `NOT GRANTED`

Prefer read-only validation. Acceptance Authorization does not authorize dependency install, production mutation, DB write, external POST, deployment, or other side-effecting validation.

## Gate 7 - Final Acceptance Judgment

Use only:

- `PASS`: all required criteria PASS and no unresolved scope/protected/baseline/provenance blocker remains.
- `PARTIAL`: no clear FAIL, but some required criteria are `UNVERIFIED`; partial reliable judgment exists.
- `BLOCKED`: the review cannot reliably continue, such as handoff conflict, baseline conflict, key provenance unresolved, or necessary evidence unavailable.
- `FAILED`: at least one required criterion has sufficient evidence `FAIL`, or a confirmed scope/protected/pre-existing/external side-effect violation exists.

`PARTIAL` means partial reliable judgment. `BLOCKED` means the review itself cannot reliably continue.

## Gate 8 - Acceptance Result + Git Closeout Handoff + STOP

Final output must have four parts:

1. `ACCEPTANCE RESULT`
2. `CRITERION REVIEW`
3. `IMPLEMENTATION REPAIR HANDOFF`
4. `GIT CLOSEOUT HANDOFF`

For PASS, Git Closeout Readiness may be `READY FOR GIT CLOSEOUT`, but Commit Authorization remains `NOT GRANTED`.

For non-PASS, Git Closeout Readiness is `NOT READY FOR GIT CLOSEOUT`.

Then STOP. Do not repair, stage, commit, push, deploy, or enter the next stage.

## STOP Contract

PASS ending:

```text
Acceptance review complete.

Acceptance Result: PASS
Git Closeout Readiness: READY FOR GIT CLOSEOUT

Commit Authorization: NOT GRANTED
Push Authorization: NOT GRANTED
Deploy Authorization: NOT GRANTED

Awaiting explicit Git Closeout authorization.
```

Non-PASS ending:

```text
Acceptance review complete.

Acceptance Result:
PARTIAL / BLOCKED / FAILED

Git Closeout Readiness:
NOT READY FOR GIT CLOSEOUT

No repair, Git write, push, or deploy was performed.

STOP.
```

## Pipeline Boundary

Preserve the cross-skill pipeline:

```text
project-reality-audit
-> STOP
-> phase-planner
-> STOP
-> scoped-implementation
-> STOP
-> acceptance-review
-> STOP
-> git-closeout
-> STOP
-> push (separate authorization)
-> deploy (separate authorization)
```

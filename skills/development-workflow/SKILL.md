---
name: development-workflow
description: Orchestrate verified development workflow stages across audit, planning, implementation, acceptance, and Git closeout while preserving authorization, evidence, scope, handoff, and STOP boundaries.
version: 0.1.0
---

# Development Workflow

## Purpose

Orchestrate the verified development workflow across reality audit, phase planning, scoped implementation, acceptance review, and Git closeout, while preserving explicit authorization boundaries, evidence provenance, scope continuity, handoff integrity, and mandatory STOP boundaries.

Core principles:

- Orchestrate, do not collapse.
- Route, do not bypass.
- Preserve authorization boundaries.
- Preserve evidence provenance.
- Preserve STOP between stages.
- A completed stage creates readiness, not authorization.
- Evidence does not create authorization.
- Discovery does not expand authorization.
- One executable next stage at a time.
- The orchestrator never turns one stage's authorization into the next stage's authorization.

## Role

`development-workflow` is a controller, router, and workflow state coordinator.

It identifies current workflow/phase/stage, detects NEW / RESUME / RECOVER / MID-WORKFLOW ENTRY, maintains Phase ID and optional Workflow ID, checks handoff completeness and trust, validates scope/protected-area/acceptance-contract continuity, evaluates evidence freshness and drift, routes repair/re-plan/re-audit, recommends exactly one next skill, and STOPs at the stage boundary.

## Non-goals

- No direct code editing.
- No Git write.
- No push.
- No deploy.
- No automatic stage chaining.
- No persistent workflow database.
- No parallel active phases.
- No CI/CD orchestration.
- No branch management.
- No PR management.
- No automatic rollback.
- No autonomous recovery.
- No multi-agent execution.

## Workflow Stages

- Stage 0: Workflow Intake
- Stage 1: Project Reality Audit
- Stage 2: Phase Planning
- Stage 3: Scoped Implementation
- Stage 4: Acceptance Review
- Stage 5: Git Closeout
- Stage 6: Push tracking only
- Stage 7: Deploy tracking only

v0.1.0 orchestration execution range stops at Stage 5. Push and Deploy are tracking-only: record readiness, authorization, and result; do not execute them.

Standard chain:

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
-> separate Push Authorization
-> separate Deploy Authorization
```

Do not automatically chain stages.

## When to Use

Use this skill when the user wants to coordinate or resume the overall development workflow, determine current workflow state, recover from drift or handoff conflict, decide the next skill, or preserve authorization and handoff continuity across stages.

Do not use this skill to perform the underlying audit, planning, implementation, acceptance review, Git closeout, push, or deploy work itself.

## Required References

Read the relevant references before making a routing decision:

- [references/workflow-state-machine.md](references/workflow-state-machine.md) for workflow modes, states, transitions, readiness, repair loops, and completion semantics.
- [references/authorization-ledger.md](references/authorization-ledger.md) for authorization types, states, precedence, freshness, scope binding, and no retroactive authorization.
- [references/handoff-contracts.md](references/handoff-contracts.md) for cross-skill handoff contracts, minimum completeness, trust, revisions, versioning, and Phase ID continuity.
- [references/scope-and-drift.md](references/scope-and-drift.md) for scope continuity, protected areas, acceptance contract continuity, evidence freshness, drift, and recovery.
- [references/routing-rules.md](references/routing-rules.md) for stage result compatibility, routing matrix, current-stage detection, mid-workflow entry, one-next-stage rule, and false-routing protection.
- [references/phase-lifecycle.md](references/phase-lifecycle.md) for Workflow vs Phase semantics, completion, new phase inheritance, baseline reuse, and cross-phase contamination protection.

## Decision Order

Every orchestration pass follows:

1. Identify workflow / phase.
2. Verify latest trusted handoff.
3. Verify repository freshness.
4. Verify scope continuity.
5. Verify protected areas.
6. Verify acceptance contract continuity.
7. Verify stage result compatibility.
8. Verify next-stage prerequisites.
9. Verify authorization.
10. Recommend exactly one next stage.
11. STOP.

## High-level Routing

Map stage results to the next candidate only after handoff, scope, evidence, and authorization checks:

- Reality Audit `PASS` -> Planning candidate.
- Phase Planner `READY` -> Implementation candidate.
- Scoped Implementation `COMPLETE` -> Acceptance candidate.
- Acceptance Review `PASS` -> Git Closeout candidate.
- Git Closeout `PASS` -> Push candidate.

Candidate does not mean ready. Ready does not mean authorized.

## Authorization Boundary

Track these separately:

- Audit Authorization
- Planning Authorization
- Implementation Authorization
- Acceptance Authorization
- Git Closeout Authorization
- Push Authorization
- Deploy Authorization

States:

- `NOT GRANTED`
- `GRANTED`
- `LIMITED`
- `STALE`
- `SUPERSEDED`
- `REVOKED`

Authorization is bound to its context. Evidence, readiness, completion, or discovery never creates authorization.

## STOP Contract

Each output must stop at a stage boundary. End with one of:

```text
Awaiting explicit <stage> authorization.
```

or:

```text
Recommended next skill: <skill>.
STOP.
```

or:

```text
Workflow blocked.
Required resolution: ...
STOP.
```

Never hide stage advancement inside the orchestration response.

## Output Contract

Always output:

```text
WORKFLOW STATUS

Workflow ID:
Phase ID:
Contract Version:
Project / Repository:

Workflow Mode:
Current Stage:
Workflow State:

Repository Baseline:
Branch:
HEAD:

Last Trusted Handoff:
Handoff Trust:
Evidence Freshness:

Phase Goal:
Effective Scope:
Protected Areas:

Stage Matrix:
- Reality Audit:
- Phase Planning:
- Scoped Implementation:
- Acceptance Review:
- Git Closeout:
- Push:
- Deploy:

Authorization Ledger:
- Audit:
- Planning:
- Implementation:
- Acceptance:
- Git Closeout:
- Push:
- Deploy:

Current Blocker:
Known Unknowns:
Known Conflicts:

Next-stage Candidate:
Next-stage Readiness:
Recommended Next Skill:
Next Required Authorization:

STOP
```

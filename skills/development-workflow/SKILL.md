---
name: development-workflow
description: Default orchestrator for continuing or resuming a software project, checking current project stage, deciding the next development step, or routing requests for audit, planning, implementation, acceptance, Git closeout, push, or deploy while preserving authorization and STOP boundaries.
version: 0.1.2
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

It first resolves whether the target project is uniquely identified, then identifies current workflow/phase/stage, detects NEW / RESUME / RECOVER / MID-WORKFLOW ENTRY, maintains Phase ID and optional Workflow ID, checks handoff completeness and trust, validates scope/protected-area/acceptance-contract continuity, evaluates evidence freshness and drift, routes repair/re-plan/re-audit, recommends exactly one next skill, and STOPs at the stage boundary.

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
  - Gate 0A: Project Identity Resolution
  - Gate 0B: Workflow / Phase Identification
  - Gate 0C: Handoff / Baseline / Authorization Intake
- Stage 1: Project Reality Audit
- Stage 2: Phase Planning
- Stage 3: Scoped Implementation
- Stage 4: Acceptance Review
- Stage 5: Git Closeout
- Stage 6: Push tracking only
- Stage 7: Deploy tracking only

Project Identity Resolution must run before workflow / phase routing. The orchestration execution range stops at Stage 5. Push and Deploy are tracking-only: record readiness, authorization, and result; do not execute them.

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

Use this skill as the default entry point when the user asks to continue a project, resume development, check where a project stands, decide what should happen next, continue the next stage, verify whether a phase is done, prepare for acceptance, prepare for commit, or continue a named project, unless the user explicitly invokes a specific downstream skill.

When the user expresses an intent such as "continue this project", "what should we do now", "check current project status and continue", "this feature is done, help me review it", or "help me prepare to commit", route through this skill first to determine the correct next skill and required authorization.

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

1. Resolve Project Identity.
2. Identify workflow / phase.
3. Verify latest trusted handoff.
4. Verify repository freshness.
5. Verify scope continuity.
6. Verify protected areas.
7. Verify acceptance contract continuity.
8. Verify stage result compatibility.
9. Verify next-stage prerequisites.
10. Verify authorization.
11. Recommend exactly one next stage.
12. STOP.

## Project Identity Gate

Stage 0 begins with Gate 0A: Project Identity Resolution. It must complete before workflow / phase routing, current-stage detection, handoff selection, repository freshness checks, or next-skill recommendation.

Project Identity states:

- `PROJECT_IDENTITY_CONFIRMED`: the target project is uniquely determined by explicit user input or trusted current context.
- `PROJECT_IDENTITY_INFERRED`: there is a strong candidate, but identity is not uniquely confirmed. This may be recorded as a candidate only and must not continue routing.
- `PROJECT_IDENTITY_AMBIGUOUS`: multiple plausible projects exist. Request that the user specify the target project and STOP.
- `PROJECT_IDENTITY_UNKNOWN`: there is not enough project identity information. Request a project name or repository and STOP.
- `PROJECT_IDENTITY_CONFLICT`: user input, current context, repository, trusted handoff, or other identity evidence conflicts. STOP and report the conflict. Do not resolve the conflict by model judgment.

Only `PROJECT_IDENTITY_CONFIRMED` allows workflow / phase routing to continue.

Evidence that may confirm project identity:

1. Explicit project name in the current user message.
2. Explicit repository path in the current user message.
3. Clear, unique, unsuperseded project context in the current conversation.
4. Trusted Workflow / Handoff project identity that agrees with the current request.
5. A known repository that uniquely maps to one project.

Memory, history, the most recent project, the most active project, the most likely project, model inference, or the highest-ranked candidate may produce project candidates, but they do not confirm project identity by themselves. Do not choose a project merely because it is the most recent, most likely, or most active project when multiple plausible projects exist.

Project Identity Confirmation is separate from Repository Verification and Baseline Verification. A clear project name can confirm `Project Identity Status = PROJECT_IDENTITY_CONFIRMED`, but it does not verify repository reality, branch, HEAD, working tree, or baseline freshness. Repository and baseline evidence must still be resolved and verified before any downstream stage that depends on them.

Examples:

- User says "continue Signivra" -> `PROJECT_IDENTITY_CONFIRMED`; continue workflow intake.
- Current conversation has clearly and only discussed Signivra, and the user says "continue this project" -> `PROJECT_IDENTITY_CONFIRMED` from current conversation context; continue workflow intake.
- New chat, multiple projects exist, and the user says "continue this project" -> `PROJECT_IDENTITY_AMBIGUOUS` or `PROJECT_IDENTITY_UNKNOWN`; ask the user to specify the project and STOP.
- User says "continue C:\zz2026\signivra" -> if the path uniquely maps to a project, `PROJECT_IDENTITY_CONFIRMED`; otherwise classify `PROJECT_IDENTITY_UNKNOWN`, `PROJECT_IDENTITY_AMBIGUOUS`, or `PROJECT_IDENTITY_CONFLICT` and STOP.
- User says "continue Signivra" but a trusted handoff points to another project -> `PROJECT_IDENTITY_CONFLICT`; report the conflict and STOP.

## High-level Routing

Map stage results to the next candidate only after handoff, scope, evidence, and authorization checks:

- Reality Audit `PASS` -> Planning candidate.
- Phase Planner `READY` -> Implementation candidate.
- Scoped Implementation `COMPLETE` -> Acceptance candidate.
- Acceptance Review `PASS` -> Git Closeout candidate.
- Git Closeout `PASS` -> Push candidate.

Candidate does not mean ready. Ready does not mean authorized.

If a user request could match a downstream skill but does not explicitly name that skill, prefer this orchestrator first when stage readiness, authorization, handoff trust, or current workflow state is unclear.

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
Project Identity:
Project Identity Status:
Project Identity Evidence:
Project Candidates:

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

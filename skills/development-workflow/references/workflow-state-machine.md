# Workflow State Machine

## Workflow Modes

- `NEW WORKFLOW`: no trusted baseline, plan, or handoff exists.
- `RESUME WORKFLOW`: a trusted handoff exists and can be used to determine the next stage.
- `RECOVER WORKFLOW`: handoff missing, conflict, stale baseline, repository drift, scope conflict, Phase ID mismatch, or materially changed goal requires recovery.
- `MID-WORKFLOW ENTRY`: the orchestrator is first invoked while the project appears to be in implementation, acceptance, closeout, or another middle stage. Verify existing contracts; do not trust user claims as state.


## Project Identity States

Stage 0 starts with Gate 0A: Project Identity Resolution. Gate 0A runs before workflow / phase routing.

- `PROJECT_IDENTITY_CONFIRMED`: the target project is uniquely determined by explicit user input or trusted current context.
- `PROJECT_IDENTITY_INFERRED`: a strong candidate exists, but project identity is not uniquely confirmed. Record the candidate, request confirmation, and STOP.
- `PROJECT_IDENTITY_AMBIGUOUS`: multiple plausible projects exist. Request that the user choose the target project and STOP.
- `PROJECT_IDENTITY_UNKNOWN`: project identity evidence is insufficient. Request a project name or repository and STOP.
- `PROJECT_IDENTITY_CONFLICT`: identity evidence conflicts across user input, current conversation context, repository, trusted handoff, memory, or history. Report the conflict and STOP.

Only `PROJECT_IDENTITY_CONFIRMED` may transition into workflow / phase routing. The other four states must STOP or wait for clarification.

Gate 0A transition:

```text
User request
-> Gate 0A Project Identity Resolution
-> PROJECT_IDENTITY_CONFIRMED
-> Gate 0B Workflow / Phase Identification
-> Gate 0C Handoff / Baseline / Authorization Intake
```

Do not use recency, likelihood, activity, memory, or model inference alone to move from Gate 0A into Gate 0B.

## Workflow States

- `INTAKE`
- `AUDIT_READY`
- `AUDIT_COMPLETE`
- `PLANNING_READY`
- `PLANNING_COMPLETE`
- `IMPLEMENTATION_READY`
- `IMPLEMENTATION_COMPLETE`
- `ACCEPTANCE_READY`
- `ACCEPTANCE_COMPLETE`
- `CLOSEOUT_READY`
- `CLOSEOUT_COMPLETE`
- `PUSH_READY`

Completion semantics:

- `COMPLETE_LOCAL` = Acceptance PASS + Git Closeout PASS.
- `COMPLETE_REMOTE` = `COMPLETE_LOCAL` + confirmed Push success.
- `DEPLOYED` = confirmed deploy success.

Do not use a vague single `COMPLETE` for these meanings.

## Stage States

- `PENDING`
- `AUTHORIZED`
- `RUNNING`
- `PASS`
- `PARTIAL`
- `BLOCKED`
- `FAILED`
- `SKIPPED`

`SKIPPED` is allowed only when the user explicitly authorizes the skip, the stage is not required for the task, and downstream contracts do not depend on it.

The standard core workflow does not skip Audit, Planning, Implementation, Acceptance, or Git Closeout by default.

## Candidate / Ready / Authorized

Keep distinct:

- `CANDIDATE`: prior result suggests a possible next stage.
- `READY`: handoff, scope, baseline, and contract checks pass for the next stage.
- `AUTHORIZED`: the user explicitly authorizes that stage.

Example:

```text
Acceptance PASS -> CLOSEOUT_CANDIDATE
handoff/scope/baseline/contract verified -> CLOSEOUT_READY
explicit user authorization -> CLOSEOUT_AUTHORIZED
```

Only `AUTHORIZED` allows a stage to start. `READY != AUTHORIZED`.

## Transition Matrix

- Project Reality Audit `PASS` -> `PLANNING_CANDIDATE`.
- Project Reality Audit `PARTIAL` -> planning only if material unknowns do not block planning.
- Project Reality Audit `BLOCKED` -> workflow `BLOCKED`.
- Phase Planner `READY` -> `IMPLEMENTATION_CANDIDATE`.
- Phase Planner `PARTIAL` -> `NOT_IMPLEMENTATION_READY`.
- Phase Planner `BLOCKED` -> workflow `BLOCKED`.
- Scoped Implementation `COMPLETE` -> `ACCEPTANCE_CANDIDATE`.
- Scoped Implementation `PARTIAL` -> `REPAIR_OR_REPLAN_REQUIRED`.
- Scoped Implementation `BLOCKED` -> workflow `BLOCKED`.
- Scoped Implementation `FAILED` -> `REPAIR_REQUIRED`.
- Acceptance Review `PASS` -> `CLOSEOUT_CANDIDATE`.
- Acceptance Review `PARTIAL` -> `NOT_CLOSEOUT_READY`.
- Acceptance Review `BLOCKED` -> workflow `BLOCKED`.
- Acceptance Review `FAILED` -> `REPAIR_REQUIRED`.
- Git Closeout `PASS` -> `PUSH_CANDIDATE`.
- Git Closeout `BLOCKED` -> workflow `BLOCKED`.
- Git Closeout `FAILED` -> `CLOSEOUT_REPAIR_REQUIRED`.

## Repair / Re-plan / Re-audit Loops

- Acceptance `FAILED` -> `REPAIR_REQUIRED` -> explicit repair authorization -> `scoped-implementation` -> `acceptance-review`.
- Material scope, architecture, or criteria change -> `PLAN_REVISION_REQUIRED` -> `phase-planner`.
- Reality-invalidating drift -> `RE-AUDIT_REQUIRED` -> `project-reality-audit`.

The orchestrator routes only. It does not repair.

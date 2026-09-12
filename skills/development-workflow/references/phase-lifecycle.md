# Phase Lifecycle

## Project / Workflow / Phase

- `Project`: repository or product context.
- `Workflow`: one orchestrated chain for a bounded development effort.
- `Phase`: one bounded unit of audit, planning, implementation, acceptance, closeout, and optional push/deploy tracking.

v0.1.0 supports one active Phase per workflow instance. It does not support parallel active phases.

## Phase Creation

A new phase must have a new Phase ID.

New phases may inherit:

- repository identity;
- project context;
- high-level constraints;
- protected areas.

New phases do not automatically inherit:

- Implementation Authorization;
- Acceptance Authorization;
- Git Closeout Authorization;
- Push Authorization;
- Deploy Authorization;
- previous Acceptance Criteria.

## Phase Completion

Acceptance PASS + Git Closeout PASS = `COMPLETE_LOCAL`.

`COMPLETE_LOCAL` + confirmed Push success = `COMPLETE_REMOTE`.

Confirmed deploy success = `DEPLOYED`.

Do not infer deploy success from push success.

## Baseline Reuse

A new phase may use light revalidation when baseline is sufficiently current and relevant. Otherwise route to full `project-reality-audit`.

## Cross-phase Contamination Protection

Evidence is phase-scoped by default.

Do not use previous phase evidence to prove a new phase unless freshness, scope relevance, and contract continuity are verified.

## Push / Deploy Tracking

Push Result states:

- `NOT_ATTEMPTED`
- `READY`
- `AUTHORIZED`
- `SUCCESS`
- `FAILED`
- `UNKNOWN`

Deploy Result states:

- `NOT_ATTEMPTED`
- `NOT_READY`
- `READY`
- `AUTHORIZED`
- `SUCCESS`
- `FAILED`
- `UNKNOWN`

development-workflow v0.1.0 tracks push/deploy only. It does not execute them.

Push success requires trusted evidence. Deploy success cannot be inferred from push success.

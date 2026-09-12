# Handoff Contracts

## Cross-skill Contract

Map and preserve:

- Workflow ID
- Phase ID
- Contract Version
- Project Identity
- Project Identity Status
- Project Identity Evidence
- Repository
- Branch
- Baseline HEAD
- Stage
- Stage Result
- Stage Revision
- Phase Goal
- Effective Scope
- Protected Areas
- Acceptance Contract Version
- Evidence
- Known Unknowns
- Known Conflicts
- Current Blockers
- Authorization State
- Next-stage Candidate
- Next-stage Readiness
- Next-stage Authorization

Project Candidates may remain an orchestrator intake / output field and is not required as a long-term field in every downstream handoff.

## Handoff Trust

Use:

- `TRUSTED`
- `PARTIAL`
- `UNTRUSTED`

Trust requires sufficient completeness, phase continuity, source credibility, and freshness for the next routing decision.

## Handoff Revision

When the same stage is re-run, increment revision.

Old handoffs may be marked `SUPERSEDED`.

Use `Latest Trusted Revision`.

Do not use old revision evidence to prove a new revision.

## Minimum Handoff Completeness

Reality Baseline minimum:

- Repository
- Branch
- HEAD
- Working Tree
- Task-Relevant Findings
- Known Unknowns
- Conflicts/Risks
- Audit Result

Phase Plan minimum:

- Phase ID
- Phase Goal
- In Scope
- Out of Scope
- Authorized Touchpoints
- Protected Areas
- Implementation Tasks
- Acceptance Criteria
- Validation Plan
- Implementation Authorization: `NOT GRANTED`

Implementation Handoff minimum:

- Phase ID
- Implementation Result
- Files Changed / Created / Deleted / Renamed
- Validation Evidence
- Scope Deviations
- Pre-existing Changes Preserved
- Claimed Acceptance Status

Acceptance Handoff minimum:

- Phase ID
- Acceptance Result
- Criterion Review
- Scope Integrity
- Validation Evidence
- Git Closeout Readiness
- Commit Authorization: `NOT GRANTED`

Git Closeout Result minimum:

- Phase ID
- Commit SHA
- Committed Scope
- Final Status
- Push Authorization

If key fields are missing:

```text
HANDOFF INCOMPLETE
BLOCKED
STOP
```

Do not guess missing fields.

## Contract Versioning

Acceptance Contract Version starts at `v1` after Phase Plan `READY`.

If the user explicitly changes Acceptance Criteria, increment to `v2`, `v3`, and so on. Re-evaluate downstream authorization and evidence freshness after contract changes.

## Phase ID Continuity

Phase ID must remain consistent across planning, implementation, acceptance, and closeout for the same phase. Mismatch requires recovery unless explicitly explained and verified.

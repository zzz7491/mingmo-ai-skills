# Routing Rules

## Current-stage Detection

Consider in order:

1. Observed repository reality.
2. Latest trusted handoff.
3. Authorization ledger.
4. User claims.

Repository reality cannot replace a missing Phase Plan or Acceptance Contract.

User claims are classified as `USER CLAIM` until verified.

## Stage Transition Checks

Before each transition, verify:

- prior stage result;
- Phase ID continuity;
- handoff completeness;
- handoff trust;
- evidence freshness;
- baseline freshness;
- scope continuity;
- protected areas;
- acceptance contract continuity;
- authorization;
- blockers/conflicts.

## Stage Result Compatibility

- Reality Audit `PASS` -> Planning candidate.
- Reality Audit `PARTIAL` -> Planning may be possible depending on material unknowns.
- Reality Audit `BLOCKED` -> Blocked.
- Phase Planner `READY` -> Implementation candidate.
- Phase Planner `PARTIAL` -> Not implementation ready.
- Phase Planner `BLOCKED` -> Blocked.
- Scoped Implementation `COMPLETE` -> Acceptance candidate.
- Scoped Implementation `PARTIAL` -> Repair or re-plan required.
- Scoped Implementation `BLOCKED` -> Blocked.
- Scoped Implementation `FAILED` -> Repair required.
- Acceptance Review `PASS` -> Git Closeout candidate.
- Acceptance Review `PARTIAL` -> Not closeout ready.
- Acceptance Review `BLOCKED` -> Blocked.
- Acceptance Review `FAILED` -> Repair required.
- Git Closeout `PASS` -> Push candidate.
- Git Closeout `BLOCKED` -> Blocked.
- Git Closeout `FAILED` -> Closeout repair required.

## Mid-workflow Entry

When the first orchestrator invocation occurs mid-workflow, verify existing contracts and handoffs. Do not treat the user's verbal state as verified state.

## One-next-stage Rule

Recommend at most one executable next stage per orchestration response.

You may show the overall pipeline, but current action must be a single next skill.

Example:

```text
Recommended Next Skill:
acceptance-review

STOP.
```

Do not continue automatically from acceptance-review to git-closeout.

## False-routing Protection

Forbidden inferences:

- Audit PASS -> Implementation.
- Plan READY -> Acceptance.
- Implementation COMPLETE -> Git Closeout.
- Acceptance PASS -> automatic Commit.
- Git Closeout PASS -> automatic Push.
- Commit exists -> Acceptance PASS.
- Push success -> Deploy success.
- Diff exists -> Implementation COMPLETE.

## Repair / Re-plan / Re-audit Routing

Acceptance `FAILED` -> `REPAIR_REQUIRED` -> explicit repair authorization -> `scoped-implementation` -> `acceptance-review` again.

Default Phase ID stays the same during ordinary repair.

If repair materially changes scope, architecture, or acceptance criteria, return to `phase-planner`.

If underlying project facts changed, return to `project-reality-audit`.

# Handoff Contract

## Skill Pipeline

Standard phase pipeline:

```text
project-reality-audit
-> phase-planner
-> scoped-implementation
-> acceptance-review
-> git-closeout
```

Downstream skills consume evidence; they do not silently reinterpret it.

Authorization never propagates automatically across skill boundaries.

Each handoff must preserve uncertainty, conflicts, scope, protected areas, evidence, and authorization state.

## Reality Audit to Phase Planner

Minimum handoff:

```text
REALITY BASELINE HANDOFF

Audit Result:
Repository:
Branch:
HEAD:
Audit Scope:
Audit Goal:

Confirmed Reality:
Partial Reality:
Not Found in Audited Scope:
Unknown:
Conflicts:

Pre-existing Changes:
Risks:
Evidence Index:
Recommended Next Stage:
```

Preserve:

- `UNKNOWN`
- `CONFLICT`
- `NOT_FOUND in audited scope`
- `PRE-EXISTING CHANGE`

## Phase Planner to Scoped Implementation

Required handoff:

```text
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
```

Implementation can begin only after explicit user authorization.

## Implementation to Acceptance

Implementation Evidence Handoff:

```text
IMPLEMENTATION RESULT

Phase ID:
Implementation Result:

Files Changed:
Files Created:
Files Deleted:

Tasks Completed:
Tasks Not Completed:

Validation Performed:
Validation Not Performed:

Test Results:
Command Results:

Scope Deviations:
Unexpected Findings:

Pre-existing Changes Preserved:

Known Remaining Issues:

Claimed Acceptance Status:
```

Implementation `PASS` is only a claim. It is not Acceptance `PASS`.

## Acceptance to Git Closeout

Acceptance handoff:

```text
ACCEPTANCE HANDOFF

Phase ID:
Acceptance Result:

Accepted Scope:
Accepted Files:

Acceptance Criteria Results:
Validation Evidence:
Known Remaining Issues:
Pre-existing Changes:

Git Closeout Eligible:
YES / NO

Commit Authorization:
NOT GRANTED
```

Acceptance `PASS` does not authorize commit.

## Authorization Chain

Keep the chain explicit:

```text
Audit Authorization
!= Planning Authorization
!= Implementation Authorization
!= Acceptance Authorization
!= Commit Authorization
!= Push Authorization
!= Deploy Authorization
```

## Evidence Provenance

Handoffs should preserve:

- Evidence ID
- Source
- Observed Fact
- Status

Downstream stages may cite upstream Evidence IDs, but must not turn historical impressions into new facts.

## Minimal Handoff Principle

Do not copy the entire project history. Carry only:

- verified facts needed by the next stage;
- scope;
- constraints;
- evidence;
- risks;
- unknowns and conflicts;
- acceptance criteria;
- authorization state.

## Handoff Conflict

If downstream evidence conflicts with an upstream handoff, report:

```text
HANDOFF CONFLICT
```

Then recommend a targeted Reality Audit or revised Phase Plan before proceeding.

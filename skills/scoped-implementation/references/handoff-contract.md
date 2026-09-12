# Handoff Contract

## Implementation Result

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
```

Implementation Result states:

- `COMPLETE`
- `PARTIAL`
- `BLOCKED`
- `FAILED`

Claimed Acceptance Status states:

- `READY FOR REVIEW`
- `NOT READY FOR REVIEW`

Implementation may never declare Acceptance `PASS`.

## Acceptance Handoff

Always output:

```text
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

## Stage Boundaries

Do not automatically enter acceptance-review.

Do not automatically enter git-closeout.

Do not automatically commit, push, deploy, migrate, or write external systems.

Acceptance Handoff is evidence for a later independent review, not acceptance itself.

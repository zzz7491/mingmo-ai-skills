# Handoff Contract

## Final Output Contract

Final output has four parts:

1. `ACCEPTANCE RESULT`
2. `CRITERION REVIEW`
3. `IMPLEMENTATION REPAIR HANDOFF`
4. `GIT CLOSEOUT HANDOFF`

## Acceptance Result

Include at least:

```text
Phase ID:
Acceptance Result:
Authorization Basis:
Acceptance Baseline Status:
Scope Integrity Result:
Implementation Result Reviewed:
Claimed Acceptance Status Reviewed:
Validation Replay Policy:
Independent Validation Performed:
Scope Violations:
Protected Area Violations:
Pre-existing Change Violations:
Unexplained Changes:
Unverified Items:
Known Remaining Issues:
Git Closeout Readiness:
```

## Criterion Review

List each criterion independently and provide summary:

```text
PASS:
FAIL:
UNVERIFIED:
NOT_APPLICABLE:
```

## Implementation Repair Handoff

For non-PASS, include:

```text
IMPLEMENTATION REPAIR HANDOFF

Phase ID:
Acceptance Result:
Failed Criteria:
Unverified Criteria:
Blocking Conditions:
Observed Evidence:
Affected Authorized Files:
Affected Protected Areas:
Recommended Repair Scope:
Scope Expansion Required:
Plan Revision Required:
Re-audit Required:
Implementation Authorization:
NOT GRANTED
```

For PASS, state that no repair handoff is required.

## Git Closeout Handoff

For PASS:

```text
GIT CLOSEOUT HANDOFF

Phase ID:
Phase Goal:
Acceptance Result:
PASS

Accepted Scope:
Accepted Files Changed:
Accepted Files Created:
Accepted Files Deleted:
Accepted Files Renamed:

Pre-existing Changes:
Unrelated Changes:

Validation Evidence:
Test Evidence:

Scope Integrity:
Protected Areas:
Known Remaining Issues:

Acceptance-reviewed HEAD:
Acceptance-reviewed Branch:
Acceptance-reviewed Working Tree:
Acceptance-reviewed Files:

Recommended Commit Scope:
Recommended Exclusions:

Git Closeout Readiness:
READY FOR GIT CLOSEOUT

Commit Authorization:
NOT GRANTED
Push Authorization:
NOT GRANTED
Deploy Authorization:
NOT GRANTED
```

For non-PASS:

```text
Git Closeout Readiness:
NOT READY FOR GIT CLOSEOUT
```

Never run `git add`, commit, push, or deploy from Acceptance Review.

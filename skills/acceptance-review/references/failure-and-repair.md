# Failure and Repair

## Acceptance Repair Loop

Acceptance Review does not fix code.

For non-PASS results, output `IMPLEMENTATION REPAIR HANDOFF`:

```text
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

Routing:

- ordinary repair inside current authorized scope can return to `scoped-implementation`;
- scope, architecture, or criteria changes should return to `phase-planner`;
- major repository reality uncertainty should return to `project-reality-audit`.

Do not automatically execute repairs.

## Non-PASS Handling

- `FAILED`: produce repair handoff focused on failed criteria and confirmed violations.
- `PARTIAL`: produce repair/review handoff for unverified criteria.
- `BLOCKED`: produce prerequisites required to resume reliable review.

No repair, Git write, push, deploy, reset, restore, stash, clean, or staging may be performed by Acceptance Review.

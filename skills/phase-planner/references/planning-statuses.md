# Planning Statuses

## Planning Result

Use only these final planning results:

- `READY`: enough verified baseline, scope, dependency, and acceptance information exists to form a trustworthy Implementation Plan. `READY` does not authorize implementation.
- `PARTIAL`: a partially trustworthy plan can be formed, but non-blocking `UNKNOWN`, unverifiable, or uncovered items remain.
- `BLOCKED`: key facts, scope, permissions, or dependencies are missing. Continuing would require guessing or crossing an authorization boundary.

## Baseline Item Types

Classify inputs as:

- `VERIFIED FACT`: evidence-supported fact from a Reality Baseline, accepted prior result, Git baseline, or newly verified evidence.
- `USER CONSTRAINT`: user instruction that governs planning.
- `USER CLAIM`: user factual assertion that must not be treated as verified without evidence.
- `UNKNOWN`: missing or insufficient evidence.

## Status Propagation

Do not silently wash upstream uncertainty into certainty.

Preserve Reality Audit statuses:

- `CONFIRMED`
- `PARTIAL`
- `NOT_FOUND in audited scope`
- `UNKNOWN`
- `CONFLICT`

`UNKNOWN` must not become `CONFIRMED` because something is "probably", "likely", or "usually" true.

Absence of evidence is not evidence of absence. Use `NOT_FOUND in audited scope` when inheriting Reality Audit findings that mean the item was not found within the audited scope.

Only new verified evidence can upgrade status. If that happens, write:

```text
Status updated based on new verified evidence.
```

## Baseline Freshness

Compare `Baseline HEAD` with `Current HEAD` when both are available. If they differ, report:

```text
BASELINE DRIFT DETECTED
```

Return `PARTIAL` when the drift is unlikely to invalidate the plan but should be reviewed. Return `BLOCKED` when the drift may affect the implementation path, scope, protected areas, or acceptance criteria.

When needed, recommend:

```text
Run targeted Project Reality Audit.
```

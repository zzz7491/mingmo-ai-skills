# Evidence Rules

## Evidence Semantics

Evidence Strength:

- `DIRECT`
- `SUPPORTED`
- `UNVERIFIED`

Evidence Source:

- `AUDIT`
- `PLAN`
- `IMPLEMENTATION`
- `ACCEPTANCE`
- `USER`

Evidence Type:

- `OBSERVED`
- `EXECUTED`
- `CLAIMED`
- `INFERRED`

User claim != verified fact.

`UNKNOWN`, `UNVERIFIED`, and `CONFLICT` must not be upgraded to `PASS` without evidence.

Use `NOT_FOUND in reviewed scope`; do not claim absolute nonexistence such as `DOES NOT EXIST` unless the reviewed scope supports that stronger statement.

## Criterion Review

Every Acceptance Criterion must be reviewed independently.

Statuses:

- `PASS`
- `FAIL`
- `UNVERIFIED`
- `NOT_APPLICABLE`

Fields:

```text
Criterion ID:
Requirement:
Type:
Status:
Evidence:
Evidence Strength:
Independent Replay:
Notes:
```

Criterion Types:

- `EXACT`
- `BEHAVIORAL`
- `STRUCTURAL`
- `NEGATIVE`
- `EVIDENTIARY`

## False-positive Protection

Do not infer:

- no visible error = `PASS`;
- file exists = feature implemented;
- test file exists = test executed;
- exit 0 = all Acceptance Criteria PASS;
- Implementation COMPLETE = Acceptance PASS;
- README/documentation says complete = implementation complete;
- no diff = correct;
- changed diff = correct.

## False-negative Protection

Judge by the contract, not reviewer preference.

Do not fail acceptance solely because of:

- unrelated pre-existing changes;
- non-blocking warning;
- test not run when criterion does not require it;
- implementation used an equivalent method;
- formatting differs outside the contract.

## Test Evidence

Test existence != Test execution != Test success.

Evidence must name what ran, whether it reached meaningful completion, and what result it produced.

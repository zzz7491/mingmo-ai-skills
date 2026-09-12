# Audit Statuses

## Fact States

Use only these states for material evidence findings:

- `CONFIRMED`: directly supported by inspected evidence.
- `PARTIAL`: some supporting evidence exists, but coverage is incomplete.
- `NOT_FOUND`: not found within the audited scope.
- `UNKNOWN`: not inspected or cannot be determined from available evidence.
- `CONFLICT`: evidence conflicts with another source, expected baseline, or user claim.

## Audit Result

Use only these final audit results:

- `PASS`: enough evidence exists to establish a trustworthy baseline. This does not mean the project has no bugs.
- `PARTIAL`: only a partial trustworthy baseline can be established; `UNKNOWN`, uncovered scope, or unverifiable items remain.
- `BLOCKED`: key access, files, evidence, or permission is insufficient to form a reliable baseline.

## Risk Labels

Use these labels for non-status analysis:

- `CONFLICT`: two or more evidence sources disagree.
- `RISK`: a condition may affect implementation, acceptance, safety, delivery, or correctness.
- `DRIFT`: documentation, schema, tests, or code appear out of sync.
- `LEGACY`: older implementation exists and may be retained, migrated, duplicated, or dead.
- `UNVERIFIED`: plausible but not confirmed by inspected evidence.

## Dirty Tree Label

Any changed, staged, modified, or untracked item that predates the audit must be labeled:

```text
PRE-EXISTING CHANGE
```

Preserve it. Do not mutate it.

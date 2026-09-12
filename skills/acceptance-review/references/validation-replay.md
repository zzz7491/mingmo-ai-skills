# Validation Replay

## Replay Policy

Use one of:

- `REUSE EVIDENCE`
- `REPLAY REQUIRED`
- `REPLAY OPTIONAL`
- `REPLAY NOT AUTHORIZED`
- `REPLAY UNAVAILABLE`

Acceptance should not mechanically repeat every implementation test.

Independent review does not mean blindly repeating every command; it means independently establishing sufficient evidence.

## Acceptance Validation Authorization

States:

- `GRANTED`
- `LIMITED`
- `NOT GRANTED`

Prefer read-only validation.

Acceptance Authorization does not automatically allow:

- dependency install;
- production mutation;
- database writes;
- external POST;
- deployment;
- side-effecting validation;
- snapshot updates;
- fixture writes;
- cache writes when persistent.

## Validation Evidence

For each replay or reused validation evidence, record:

- command or method;
- source;
- whether it was executed or reused;
- result;
- evidence strength;
- side-effect assessment;
- criteria it supports.

If replay is unavailable or not authorized, mark affected criteria `UNVERIFIED` unless other evidence is sufficient.

## Negative Criteria Replay

Negative criteria often use read-only evidence:

- no files outside scope modified;
- no commit occurred;
- protected area unchanged;
- no deploy/push/external write occurred.

Do not infer negative criteria PASS merely because no one claimed a violation. Seek evidence appropriate to the contract.

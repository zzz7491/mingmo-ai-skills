# Failure and STOP Rules

## BLOCKED vs FAILED

- `BLOCKED`: work cannot proceed because authorization, access, baseline, scope, tool availability, or prerequisite evidence is missing.
- `FAILED`: authorized work or authorized validation was attempted and failed in a way that prevents claiming readiness for review.

Use `PARTIAL` when some authorized work completed but remaining work is blocked, unavailable, or not authorized.

## Mandatory STOP Conditions

STOP when:

- no implementation authorization exists;
- authorization is ambiguous;
- baseline conflict affects implementation;
- current state conflicts with protected areas;
- required work crosses scope;
- delete/rename/new file is needed but not authorized;
- pre-existing changes cannot be safely preserved;
- validation requires unauthorized side effects;
- dependency installation is needed but not authorized;
- environment mutation is needed but not authorized;
- external write is needed but not authorized;
- Git write/history operation is needed but not authorized;
- a failed mutating command leaves uncertain state;
- retry may compound side effects;
- handoff conflict is detected.

## Failed Mutating Command Rule

If an authorized mutating command fails, inspect only enough to determine state and report truthfully. Do not run broad repair commands, reset, clean, stash, or retry blindly.

## Retry / Idempotence Rule

Retry only when:

- the operation is known idempotent, or
- the previous attempt made no mutation, or
- the user explicitly authorizes the retry with known side-effect risk.

## Unauthorized Side Effects

If an unauthorized side effect occurs, stop, report:

- action;
- observed effect;
- affected files/systems;
- evidence;
- remaining risk;
- required next action.

Do not hide, revert, or "clean up" without authorization.

## Handoff Conflict

If current evidence conflicts with the Phase Plan, Reality Baseline, or Implementation Handoff, report `HANDOFF CONFLICT` and stop unless the conflict is immaterial and clearly does not affect scope, tasks, protected areas, or acceptance.

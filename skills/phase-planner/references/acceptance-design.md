# Acceptance Design

## Acceptance Criteria

Acceptance Criteria must be:

- observable;
- specific;
- bounded;
- evidence-producing.

Avoid vague criteria:

- "works correctly";
- "is better";
- "cleaner";
- "improved";
- "production ready" without evidence conditions.

Good criteria name the behavior, boundary, evidence, and forbidden side effects.

Examples:

- target runtime path reaches the verified adapter;
- existing behavior remains unchanged;
- no SMS implementation is introduced;
- no files outside authorized scope are modified.

## Validation Plan

The planner designs validation; it does not run it.

Classify each validation item as:

- `REQUIRED VALIDATION`
- `OPTIONAL VALIDATION`
- `NOT AUTHORIZED`

Record:

```text
Method / Command:
Expected Result:
Side-effect Risk:
Authorization Requirement:
```

Testing evidence must be truthful:

- test exists does not mean test passes;
- test plan exists does not authorize execution;
- static analysis is not runtime validation;
- implementation `PASS` is not acceptance `PASS`.

## Non-regression Checks

Non-regression checks should be tied to the phase goal and protected areas. They should identify the existing behavior expected to remain unchanged and the evidence that would demonstrate that.

## Forbidden Side Effects

Name side effects that must not occur, such as:

- files outside authorized scope modified;
- migration executed;
- dependency installed or upgraded;
- database writes;
- production config changed;
- unrelated WIP altered;
- Git commit created without separate commit authorization.

## Acceptance Before Implementation

Define acceptance before implementation begins. If acceptance cannot be designed because the target behavior or evidence path is unknown, return `BLOCKED` and require a targeted Reality Audit or goal clarification.

# Acceptance Rules

## Authorization

Implementation Authorization != Acceptance Authorization != Commit Authorization != Push Authorization != Deploy Authorization.

Acceptance Authorization != Validation Mutation Authorization.

`READY FOR REVIEW` is not Acceptance Authorization.

Acceptance Review does not stage, commit, push, deploy, repair code, install dependencies, mutate production, write databases, or enter Git Closeout.

## Gate 0-8 Summary

- Gate 0: Acceptance Authorization.
- Gate 1: Handoff & Phase Identity Check.
- Gate 2: Acceptance Baseline Revalidation.
- Gate 3: Scope Integrity Review.
- Gate 4: Implementation Evidence Review.
- Gate 5: Acceptance Criteria Verification.
- Gate 6: Validation / Test Evidence Review.
- Gate 7: Final Acceptance Judgment.
- Gate 8: Acceptance Result + Git Closeout Handoff + STOP.

## Original Acceptance Criteria Authority

Priority:

```text
Latest explicit user amendment
> Original authorized Acceptance Criteria
> Acceptance Handoff copy
> Implementation claims
```

If Phase Plan and Acceptance Handoff acceptance criteria conflict, output:

```text
ACCEPTANCE CONTRACT CONFLICT
BLOCKED
STOP
```

Do not:

- relax standards;
- delete standards;
- change required to optional;
- change `must` or `exact` semantics;
- add reviewer preference as a new acceptance requirement.

## Acceptance Result States

- `PASS`: all required criteria PASS and no unresolved scope/protected/baseline/provenance blocker exists.
- `PARTIAL`: no clear FAIL, but some required criteria are `UNVERIFIED`; partial reliable judgment exists.
- `BLOCKED`: the review itself cannot reliably continue.
- `FAILED`: a required criterion has sufficient evidence `FAIL`, or a confirmed scope/protected/pre-existing/external side-effect violation exists.

## Stage Boundary

Acceptance PASS != Commit Authorization.

Git Closeout Readiness != Commit Authorization.

Acceptance Review is not Git Closeout and must not run `git add`, commit, push, reset, restore, stash, clean, or deployment.

If premature Git write is detected, record `PREMATURE GIT WRITE DETECTED`.

If unauthorized push, deploy, or external write occurred, record `UNAUTHORIZED EXTERNAL SIDE EFFECT`; this usually means Acceptance `FAILED`.

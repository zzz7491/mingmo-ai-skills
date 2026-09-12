# Provenance Rules

## Source-of-Truth / Evidence Hierarchy

Use this hierarchy:

```text
Observed repository reality
> Executed acceptance evidence
> Original authorized Phase Plan
> Implementation evidence
> Implementation claims
```

Observed reality overrides implementation claims.

Observed state does not automatically prove provenance.

State is not provenance.

## Acceptance Baseline Freshness

Classify:

- `ACCEPTANCE BASELINE MATCH`
- `ACCEPTANCE BASELINE DRIFT`
- `ACCEPTANCE BASELINE CONFLICT`

Check at least:

- Repository
- Branch
- HEAD
- Working Tree
- Target Paths
- Accepted Scope
- Pre-existing Changes
- Post-implementation Changes

If implementation completed and a target file changed afterward:

```text
POST-IMPLEMENTATION CHANGE DETECTED
ACCEPTANCE BASELINE CONFLICT
Acceptance Result = BLOCKED
```

This is not automatically implementation `FAILED`.

## Scope Integrity

Compare Authorized Scope vs Observed Changed Scope.

Classify changed files:

- `AUTHORIZED CHANGE`
- `PRE-EXISTING CHANGE`
- `UNRELATED CHANGE`
- `UNEXPLAINED CHANGE`
- `SCOPE VIOLATION`

A changed file outside authorized scope is not automatically an implementation violation; determine provenance first.

Check Protected Areas. If current implementation clearly modified a protected area, Acceptance is usually `FAILED`.

## Provenance States

- `PRE-EXISTING`
- `CURRENT IMPLEMENTATION`
- `POST-IMPLEMENTATION`
- `UNKNOWN PROVENANCE`

`UNKNOWN PROVENANCE` must not be treated directly as implementation violation.

Evidence that can support provenance:

- implementation preflight status;
- implementation final status;
- before/after diff;
- Git status / diff;
- command evidence;
- repository state;
- timestamps as weak auxiliary evidence only.

## Pre-existing Changes

Review:

- pre-existing modified files;
- pre-existing untracked files;
- pre-existing staged changes;
- target files with prior edits.

If implementation reset, overwrote, cleaned, stashed/dropped, committed unrelated WIP, or otherwise damaged pre-existing changes:

```text
PRE-EXISTING CHANGE VIOLATION
```

This usually means Acceptance `FAILED`.

Do not automatically restore, reset, stash, clean, or unstage.

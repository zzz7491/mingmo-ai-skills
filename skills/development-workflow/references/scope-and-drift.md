# Scope and Drift

## Phase Scope Contract

Maintain:

- Phase ID
- Original In Scope
- Original Out of Scope
- Authorized Touchpoints
- Protected Areas
- Current Effective Scope

## Scope Continuity

Classify scope drift:

- `NO_SCOPE_DRIFT`
- `SCOPE_NARROWED`
- `SCOPE_EXPANDED_AUTHORIZED`
- `SCOPE_EXPANDED_UNAUTHORIZED`
- `SCOPE_CONFLICT`

`SCOPE_EXPANDED_UNAUTHORIZED` -> `BLOCKED + STOP`.

`SCOPE_CONFLICT` -> `BLOCKED + STOP`.

Minor explicit scope extension may use lightweight plan revision if Phase Goal, architecture, and Acceptance Criteria did not materially change.

Material extension, such as new service, migration, external API, architecture, or acceptance criteria, requires `PLAN_REVISION_REQUIRED`.

## Protected Areas

Protected Areas stay the same or become stricter by default.

Downstream skills may not reduce Protected Areas. Reducing a protected area requires explicit user authorization.

Otherwise:

```text
Protected Area Conflict
BLOCKED
STOP
```

## Acceptance Contract Continuity

Implementation must not modify Acceptance Criteria.

If the user explicitly modifies criteria, increment Acceptance Contract Version and re-evaluate downstream authorizations and evidence freshness.

## Evidence Freshness

Evidence freshness states:

- `CURRENT`
- `STALE`
- `SUPERSEDED`
- `UNKNOWN`

Evidence may become `STALE` when:

- target file changed;
- target HEAD materially changed;
- implementation revision changed;
- acceptance contract changed;
- branch changed;
- environment materially changed.

Evidence is phase-scoped by default. Avoid cross-phase contamination.

## Drift

Classify drift:

- `NON_MATERIAL_DRIFT`: unrelated file/docs changes; record and continue if safe.
- `MATERIAL_DRIFT`: affects target scope, validation, or acceptance; `REVALIDATION_REQUIRED`.
- `CONFLICTING_DRIFT`: handoff cannot reliably map to repository state; `RECOVER WORKFLOW`.

Branch change triggers revalidation by default.

Repository change makes old workflow `STALE` unless clone/mirror baseline equivalence is proven.

## Recovery Routing

- Reality-invalidating drift -> `project-reality-audit`.
- Plan-invalidating drift -> `phase-planner`.
- Acceptance `FAILED` -> `REPAIR_REQUIRED` -> explicit repair authorization -> `scoped-implementation` -> `acceptance-review`.
- Material scope/architecture/criteria changes -> `PLAN_REVISION_REQUIRED` -> `phase-planner`.
- Git state/scope closeout issue -> `git-closeout`.

The orchestrator routes only and does not repair.

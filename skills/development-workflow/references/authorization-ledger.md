# Authorization Ledger

## Authorization Types

Track separately:

- Audit Authorization
- Planning Authorization
- Implementation Authorization
- Acceptance Authorization
- Git Closeout Authorization
- Push Authorization
- Deploy Authorization

Also track Validation Authorization separately from External Write Authorization.

## States

- `NOT GRANTED`
- `GRANTED`
- `LIMITED`
- `STALE`
- `SUPERSEDED`
- `REVOKED`

Each ledger item records:

- Status
- Scope
- Basis
- Freshness

## Core Rules

Audit Authorization != Planning Authorization != Implementation Authorization != Acceptance Authorization != Git Closeout Authorization != Push Authorization != Deploy Authorization.

Validation Authorization != External Write Authorization.

Evidence != Authorization.

Authorization is bound to its context.

## Freshness Checks

Re-evaluate authorization freshness when:

- Phase ID changed;
- Phase Goal materially changed;
- scope changed;
- protected areas changed;
- target repository changed;
- target branch changed;
- acceptance contract changed;
- baseline conflict occurred;
- repair introduces new files or modules;
- plan revision occurs.

## Precedence

Use the latest explicit user instruction for the same authorization context, then explicit protected/forbidden areas, then trusted handoff contracts, then evidence.

Later explicit narrowing makes older broader authorization `SUPERSEDED`.

Later expansion requires explicit user authorization.

## No Retroactive Authorization

Past unauthorized actions remain violations even if the user later authorizes similar actions. Later authorization cannot rewrite historical authorization state.

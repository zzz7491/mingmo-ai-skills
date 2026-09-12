# Authorization Rules

## Core Boundary

Implement only the explicitly authorized plan.

Authorization never propagates automatically:

```text
Planning Authorization
!= Implementation Authorization
!= Acceptance Authorization
!= Commit Authorization
!= Push Authorization
!= Deploy Authorization
```

Validation Authorization != External Write Authorization.

Evidence != Authorization. A file can be proven relevant, active, or authoritative and still be unauthorized for modification.

## Implementation Authorization States

- `FULL IMPLEMENTATION AUTHORIZATION`: every task and authorized file/area in the implementation handoff is authorized for implementation.
- `PARTIAL IMPLEMENTATION AUTHORIZATION`: only named tasks, files, directories, commands, or validation actions are authorized.
- `NO IMPLEMENTATION AUTHORIZATION`: no implementation work may start.

When authorization is partial, implement only the authorized portion and report skipped work as partial or blocked.

## Re-authorization Mechanics

Request re-authorization when:

- a task needs a file, directory, command, external write, dependency install, migration, deploy, delete, rename, or protected area outside the current authorization;
- baseline drift or conflict changes the implementation path;
- validation requires side effects that were not authorized;
- a retry may repeat or compound a side effect;
- implementation needs to cross from planning, implementation, acceptance, commit, push, or deploy into another stage.

Re-authorization must name the requested action, evidence, affected scope, and reason the current plan is insufficient.

## Authorization Precedence

Use this precedence:

1. Latest explicit user instruction in the current authorization context.
2. Explicit forbidden/protected areas.
3. Phase Plan / Implementation Handoff.
4. Reality Baseline and evidence.

If two instructions conflict, follow the stricter boundary and report the conflict.

## Command Authorization Categories

Classify commands before execution:

- `READ_ONLY`: reads files, metadata, Git state, or local command output without mutation.
- `AUTHORIZED_MUTATION`: explicitly authorized mutation within scope.
- `NOT_AUTHORIZED`: mutation or side effect not authorized.
- `UNSAFE`: side effects are unknown, broad, persistent, or external.
- `UNAVAILABLE`: command/tool cannot be run in the current environment.

Read-only Git is allowed where appropriate. Git write/history operations are outside normal implementation unless separately authorized.

## External Write Boundary

External writes include databases, production systems, remote services, APIs, cloud resources, deploy targets, package registries, issue trackers, and notifications to others. None are authorized by implementation authorization alone.

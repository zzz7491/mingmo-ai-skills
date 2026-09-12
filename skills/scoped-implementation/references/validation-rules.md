# Validation Rules

## Validation Authorization States

- `AUTHORIZED`: explicitly allowed and within scope.
- `NOT_AUTHORIZED`: not allowed by the plan or user.
- `UNSAFE`: may write files, databases, external systems, caches, fixtures, snapshots, generated artifacts, or production state.
- `UNAVAILABLE`: cannot run because a tool, dependency, environment, or access is missing.

## Validation Result States

- `PASS`: ran to meaningful completion and produced expected evidence.
- `FAIL`: ran and produced a failing result.
- `UNVERIFIED`: could not be verified safely or completely.
- `NOT_RUN`: intentionally not run, usually due to authorization, safety, or availability.

Do not claim PASS unless the validation actually ran to its meaningful completion.

## Validation Failure Decision Logic

When validation fails:

1. Determine whether the failure is inside authorized implementation scope.
2. Determine whether fixing it requires new authorization.
3. Determine whether retrying may repeat or compound side effects.
4. Fix only authorized in-scope causes.
5. STOP when the cause is outside scope, unsafe, unavailable, or requires new authorization.

## Formatter / Linter Boundary

Formatters and linters can write files. Run write-mode formatters/lint fixes only when explicitly authorized and bounded to authorized files.

Read-only lint/check commands may run only when authorized as validation and safe in the environment.

## Dependency Installation Boundary

Dependency installation is not normal implementation. It can modify lockfiles, caches, environments, and external state. Run only with explicit authorization.

## Environment Mutation Boundary

Do not modify environment variables, local services, config files, system state, containers, databases, or production-like resources unless explicitly authorized.

## External Write Boundary

Validation authorization does not authorize external writes. Tests or checks that write remote services, databases, queues, emails, messages, cloud resources, or production systems require separate explicit external-write authorization.

## Tool Side-effect Policy

Before running a tool, classify likely side effects. If unknown and potentially persistent, treat as `UNSAFE` and do not run.

## Test Evidence

Test existence does not mean tests pass. Static checks do not prove runtime behavior unless the acceptance criteria only require static validation.

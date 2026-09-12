# Scope Rules

## Required Scope Sections

Every Phase Plan must include:

- `IN SCOPE`
- `OUT OF SCOPE`
- `AUTHORIZED TOUCHPOINTS`
- `PROTECTED AREAS`

If there are no extra out-of-scope items beyond global safety boundaries, write:

```text
No additional out-of-scope items identified beyond global safety boundaries.
```

## Evidence vs Authorization

Evidence is not authorization. Evidence that a file is relevant does not authorize modification.

Do not infer modification permission from:

- `CONFIRMED`;
- verified evidence;
- active runtime path;
- authoritative implementation path.

Use `AUTHORIZED FILES` only when:

- the user explicitly authorized those specific files; or
- the files clearly fall inside a user-authorized implementation scope.

Use `CONFIRMED TOUCHPOINT` when verified evidence shows a file, module, route, or service is relevant, active, or authoritative, but modification authorization has not been granted.

Use `LIKELY TOUCHPOINT` when a file, module, route, or service may be involved but has not been verified.

Do not disguise relevance evidence as modification authorization.

## Protected Areas

Protected Areas should include:

- `PRE-EXISTING CHANGE`;
- unrelated modules;
- legacy implementation unless explicitly in scope;
- production configuration;
- migrations;
- user-declared forbidden areas;
- external systems or databases without explicit write authorization.

Do not plan to stash, reset, clean, discard, format, or commit unrelated WIP.

## Scope Conflict

If the user's goal requires touching a forbidden area, protected area, unauthorized module, or scope-out file, do not expand scope. Report:

```text
SCOPE CONFLICT

Required implementation touches a protected or forbidden area.

Planning Result:
BLOCKED
```

Wait for revised authorization or a revised goal.

## Scope Freeze

After the user authorizes a Phase Plan, that plan becomes the implementation scope baseline.

If implementation later needs an extra module, migration, dependency upgrade, protected file, out-of-scope file, new service, or database write, it must report:

```text
SCOPE DEVIATION DETECTED

Deviation:
Evidence:
Why current plan is insufficient:
Affected scope:
Required authorization:
```

Then stop.

## Newly Discovered Scope

Newly discovered problems or missing pieces are reported, not absorbed automatically. Do not include tasks such as:

- "fix any other issues discovered";
- "clean up related code";
- "refactor all nearby modules";
- "optimize surrounding implementation".

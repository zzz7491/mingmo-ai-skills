# Acceptance Rules

## Closeout passes only when
- the target repository and branch are known;
- the intended change set is complete;
- every committed path is inside the authorized scope;
- required validation passes;
- staged content is reviewed after staging;
- `git diff --cached --check` reports no whitespace errors requiring intervention;
- the commit succeeds;
- the resulting commit identity is verified;
- final repository state is inspected and truthfully reported.

## Closeout is blocked when
- scope is ambiguous;
- unexpected files cannot be safely separated;
- required validation fails;
- merge conflicts exist;
- repository state makes the requested commit unsafe;
- the requested action would require an ungranted higher-risk action.

## Existing unrelated changes
Unrelated pre-existing changes must be preserved. Do not stash, reset, checkout, restore, clean, delete, or otherwise alter them unless the user explicitly authorizes that separate action.

## Tests
Use project-defined validation when available. Do not invent an expensive full-suite requirement when the project has a narrower accepted validation command. Conversely, do not skip explicitly required validation merely because the diff appears small.

## Commit message
Use a user-provided message when supplied. Otherwise derive a concise message only if the user has authorized creation of the closeout commit and the accepted change is unambiguous.

# Safety Boundaries

The Git Closeout skill is intentionally conservative.

## Never do implicitly
- `git push` or force-push;
- deploy to production or preview environments;
- write to remote/production databases;
- run destructive database migrations;
- amend or rewrite existing history;
- rebase or reset branches;
- discard local changes;
- delete untracked files;
- stash unrelated work;
- change branches solely to make closeout easier;
- fix unrelated defects, formatting, lint, dependencies, or technical debt;
- expand the authorized file scope.

## Authorization boundary
Authorization to **commit** does not imply authorization to **push**.
Authorization to **close out Git** does not imply authorization to **deploy**.
Authorization to **run tests** does not imply authorization to **repair unrelated failures**.

When a higher-risk action is needed, stop at the completed safe boundary and request explicit authorization for that action.

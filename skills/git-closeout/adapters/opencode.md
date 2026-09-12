# OpenCode Adapter

Use the root `SKILL.md` as the workflow contract.

For OpenCode-style repository execution:
- inspect the repository directly rather than relying on conversational summaries;
- keep edits outside this skill: Git Closeout is for acceptance/commit of an already completed change;
- use shell/Git commands for deterministic verification;
- stage explicit authorized paths rather than broad staging when scope is file-bounded;
- stop and return evidence when a gate fails;
- do not push or deploy unless a separate explicit authorization is provided.

Recommended invocation:

`Use the git-closeout skill to close out the completed phase. Authorized scope: <paths/change-set>. Validation: <commands>. Do not push or deploy.`

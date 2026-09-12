# OpenCode Adapter Notes

Use this adapter when applying `scoped-implementation` with OpenCode or another repository-aware coding agent.

- `SKILL.md` is the controlling specification.
- Keep implementation task-by-task and bounded to authorized files, directories, commands, and validation.
- Do not run broad refactors, formatters, dependency installs, Git writes, or external writes unless explicitly authorized.
- Treat discovery as evidence, not expanded authorization.
- Report baseline drift, scope deviation, handoff conflict, and unauthorized side effects instead of silently repairing them.
- Output `IMPLEMENTATION RESULT` and `ACCEPTANCE HANDOFF`, then STOP.

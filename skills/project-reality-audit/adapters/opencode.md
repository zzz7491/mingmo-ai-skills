# OpenCode Adapter Notes

Use this adapter when applying `project-reality-audit` with OpenCode or another coding agent that can directly inspect a repository.

- Follow `SKILL.md` as the controlling specification.
- Use read-only shell commands and file reads only.
- Do not rely on agent workspace power as permission to stage, commit, format, install, migrate, deploy, or repair.
- Preserve dirty-tree work exactly as found and label it `PRE-EXISTING CHANGE`.
- Prefer targeted search and dependency tracing over broad full-repository reads.
- After the Reality Baseline report, STOP and wait for explicit implementation authorization.

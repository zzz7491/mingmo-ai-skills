# Generic Agent Adapter Notes

Use this adapter for compatible AI agent environments without platform-specific behavior.

- `SKILL.md` is the controlling specification.
- Implementation requires explicit implementation authorization.
- Evidence is not authorization.
- Validation authorization does not allow external writes.
- Do not automatically enter acceptance-review, git-closeout, commit, push, or deploy.
- Output `IMPLEMENTATION RESULT` and `ACCEPTANCE HANDOFF`, then STOP.

# OpenCode Adapter Notes

Use this adapter when applying `development-workflow` with OpenCode or another coding agent.

- `SKILL.md` is the controlling specification.
- Return a routing decision only.
- Do not auto-chain commands or execute downstream skills.
- Do not modify code as the orchestrator.
- Validate handoff, scope, drift, and authorization before recommending the next skill.
- STOP at the stage boundary.

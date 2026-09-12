# ChatGPT Adapter Notes

Use this adapter when applying `acceptance-review` in ChatGPT or Codex-style environments.

- `SKILL.md` is the controlling specification.
- Acceptance must be explicitly authorized.
- Treat implementation output as evidence input, not acceptance fact.
- Prefer read-only validation and avoid side-effecting tools unless explicitly authorized.
- Do not repair, stage, commit, push, deploy, or automatically enter Git Closeout.
- Output the four-part acceptance result and STOP.

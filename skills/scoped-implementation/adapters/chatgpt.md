# ChatGPT Adapter Notes

Use this adapter when applying `scoped-implementation` in ChatGPT or Codex-style environments.

- `SKILL.md` is the controlling specification.
- Implement only after explicit implementation authorization.
- Do not treat planning, validation, acceptance, commit, push, or deploy authorization as interchangeable.
- Do not infer file modification permission from evidence or touchpoint status.
- Preserve pre-existing changes and report scope deviations.
- Output `IMPLEMENTATION RESULT` and `ACCEPTANCE HANDOFF`, then STOP.

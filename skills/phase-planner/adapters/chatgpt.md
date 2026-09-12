# ChatGPT Adapter Notes

Use this adapter when applying `phase-planner` in ChatGPT or Codex-style environments.

- `SKILL.md` is the controlling specification.
- Planning only; do not implement, edit files, run unauthorized validation, commit, push, deploy, or install dependencies.
- Treat memories, pasted conversations, user claims, and prior summaries as inputs to classify, not automatic facts.
- Preserve upstream `UNKNOWN`, `CONFLICT`, `NOT_FOUND in audited scope`, and `PRE-EXISTING CHANGE`.
- Do not use tool availability as permission to expand scope.
- Output the phase plan, then STOP and wait for explicit implementation authorization.

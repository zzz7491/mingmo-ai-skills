# OpenCode Adapter Notes

Use this adapter when applying `acceptance-review` with OpenCode or another repository-aware coding agent.

- `SKILL.md` is the controlling specification.
- Revalidate repository reality with read-only inspection when authorized.
- Do not modify implementation while reviewing it.
- Preserve provenance distinctions: state is not provenance.
- Record handoff conflicts, baseline conflicts, and protected-area violations instead of silently repairing them.
- Output the four-part acceptance result and STOP.

# Generic Agent Adapter Notes

Use this adapter for compatible AI agent environments without platform-specific behavior.

- `SKILL.md` is the controlling specification.
- Planning only.
- Do not expand authorization based on available tools.
- Preserve evidence status and authorization state across handoffs.
- Do not silently resolve `UNKNOWN` or `CONFLICT`.
- Report scope conflicts instead of crossing protected or forbidden areas.
- Output the phase plan, then STOP and wait for explicit implementation authorization.

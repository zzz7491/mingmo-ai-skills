# Generic Agent Adapter Notes

Use this adapter for compatible AI agent environments without platform-specific behavior.

- `SKILL.md` is the controlling specification.
- Act as controller/router, not implementation agent.
- Preserve authorization boundaries and evidence provenance.
- Distinguish candidate, ready, and authorized.
- Recommend one next stage and STOP.
- Do not push, deploy, commit, mutate files, or execute autonomous recovery.

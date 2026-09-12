# ChatGPT Adapter Notes

Use this adapter when applying `project-reality-audit` in ChatGPT or Codex-style environments.

- Follow `SKILL.md` as the controlling specification.
- Keep the audit read-only even when tools can edit files, run terminals, use connectors, or control apps.
- Treat pasted conversations, memories, documents, and user claims as leads until verified against current evidence.
- Use concise progress updates while inspecting, but do not turn progress into implementation.
- Do not run tests unless they are confirmed read-only or explicitly authorized.
- After the Reality Baseline report, STOP and wait for explicit implementation authorization.

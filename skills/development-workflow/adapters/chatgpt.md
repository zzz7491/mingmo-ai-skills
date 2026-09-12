# ChatGPT Adapter Notes

Use this adapter when applying `development-workflow` in ChatGPT or Codex-style environments.

- `SKILL.md` is the controlling specification.
- Preserve stage STOP boundaries.
- Recommend only one next skill.
- Never imply authorization from readiness, completion, evidence, or user claims.
- Keep the workflow snapshot concise and include the authorization ledger.
- Do not modify code, run Git writes, push, deploy, or auto-chain stages as the orchestrator.
- Treat `development-workflow` as the preferred ChatGPT entry point for ordinary project-continuation requests such as continuing development, resuming a named project, checking current project status, deciding the next step, preparing acceptance, or preparing commit, when the user has not explicitly named a downstream skill.
- Do not bypass the orchestrator merely because the user mentions acceptance, commit, next stage, or current status; first determine whether routing, authorization, or handoff checks are needed.
- If the user explicitly names a downstream skill, honor that explicit skill request.
- For ordinary continuation requests, resolve project identity before routing to any downstream skill.
- In a new chat or multi-project environment, do not resolve "this project" to a specific project using memory, recency, likely intent, or the previous chat alone.
- If multiple plausible project candidates exist, ask the user to specify the target project and STOP.
- If the user explicitly provides a project name or repository path, treat it as the highest-priority project identity input.
- An explicit project name confirms project identity only; it does not automatically verify repository baseline, branch, HEAD, working tree, or evidence freshness.
- Do not automatically continue the most recent project merely because it was the last project discussed.

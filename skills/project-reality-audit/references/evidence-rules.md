# Evidence Rules

## Core Rules

Absence of evidence is not evidence of absence.

Use these distinctions:

- `FACT`: directly observed from code, config, schema, test, Git output, command output, or other inspected artifact.
- `INFERENCE`: reasoned conclusion based on facts; label it as inference.
- `PROPOSAL`: suggested next action; never present it as existing reality.

Important anti-hallucination rules:

- Not found does not mean nonexistent.
- Documentation claim does not mean implemented.
- File exists does not mean connected to the production path.
- Test exists does not mean test passes.
- Schema exists does not mean migration has been applied.
- Adapter exists does not mean runtime calls it.
- Config key exists does not mean production enables it.

## Evidence Expectations

Important conclusions should have evidence whenever possible. Prefer exact files, symbols, command outputs, and line numbers when practical.

When evidence is partial, say what was confirmed and what remains unverified. Do not fill gaps with confident language.

## User Claims

User-provided baselines are useful leads, not confirmed facts. Verify them against repository evidence. If evidence conflicts with the user's claim, classify the result as `CONFLICT` or `REQUIRES VERIFICATION` and explain the evidence.

## NOT_FOUND Wording

Use `NOT_FOUND in audited scope`. Do not write absolute claims such as "does not exist" unless the audit scope truly covers all possible locations and the evidence supports that stronger conclusion.

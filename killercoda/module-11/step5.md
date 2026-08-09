# Step 5 — Permission modes and the session workflow

You've built the config; now the **operating discipline** that uses it. Claude Code runs in a
**permission mode** that sets how much it does before pausing for you:

| Mode | Behaviour | Use when |
|---|---|---|
| **default** | asks before each mutating action | normal work — you review each step |
| **acceptEdits** | file edits auto-approved; commands still ask | a well-scoped edit you trust |
| **plan** | read-only; proposes a plan, changes nothing | exploring or reviewing before acting |
| **dangerously-skip** | no prompts at all | throwaway sandbox only — never on real work |

Your `settings.json` allowlist is what makes **default** mode fast without going blind: the read-only
commands you approved never interrupt; anything that mutates state outside the repo still stops for you.

Reason through the **session loop** you'll run once your key is set locally:

1. **Prime** — the agent auto-loads `CLAUDE.md`; you state the goal and a **check** ("done" = it passes).
2. **Plan** — in plan mode, get the approach; correct it *before* any edit is made.
3. **Act** — switch to default/acceptEdits; the agent edits and runs allowed commands.
4. **Verify** — you read the diff and the check output — you are the **engineer of record**.
5. **Commit** — the change lands in the repo (M8); the config that shaped it is committed alongside it.

You've now scaffolded every input to that loop — rules, a command, a skill, and a permissions gate —
without spending a single token. Add your key locally and the same files direct real work.

Click **Continue** to wrap up.

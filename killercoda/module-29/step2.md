# Step 2 — Hooks: deterministic guardrails

A **hook** is a shell command Claude Code runs automatically when a lifecycle **event** fires. The agent
is *probabilistic* — an instruction can be missed or injected past; a hook is *not* — it runs by
machinery, every time. That is the reliability argument: **for anything that MUST hold, use a hook, not a
prompt instruction.**

Config lives in `.claude/settings.json` under a top-level `"hooks"` key. Each event maps to an array of
matcher objects, each with a `"hooks"` list of `{"type": "command", "command": "…"}` entries.

Make sure you're in the project:

```bash
cd ~/agent-lab && mkdir -p .claude
```{{exec}}

Write two guardrails — a **PostToolUse** hook (lint after an edit) and a **Stop** hook (audit every
session to a trail):

```bash
cat > .claude/settings.json <<'EOF'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "shellcheck *.sh 2>/dev/null || true" }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          { "type": "command", "command": "echo \"$(date -Is) session-stop\" >> .claude/audit.log" }
        ]
      }
    ]
  }
}
EOF
```{{exec}}

Prove it is valid JSON — a broken settings file is silently ignored:

```bash
python3 -m json.tool .claude/settings.json
```{{exec}}

Two events, two jobs: **PostToolUse** (matcher `Edit|Write`) lints *after* the agent edits a file;
**Stop** appends an **audit** line when the turn ends — accountability, now automatic (M23/M24). The audit
hook is the load-bearing one: its log *is* the trail you read to debug a flailing agent.

> The protective sibling to journal: a **PreToolUse** hook on `secrets/` can **block** an edit *before* it
> happens — M24's estate protection enforced by machinery, not trust. You'll verify all the config
> together in the next step.

# Done — you can direct an AI engineer

Without an API key, you built the whole configuration surface that steers Claude Code:

- A **pruned `CLAUDE.md`** — only universal, non-inferable facts, so the rules never drown.
- A **`.claude/` project**: a **slash command** (`$ARGUMENTS`) and a **skill** (frontmatter + workflow).
- A **narrow permissions allowlist** in valid JSON — least privilege, no `Bash(*)`.
- The **permission modes** and the **prime → plan → act → verify → commit** session loop.

**Back on the lesson page:** do the *Self-Check* and *Solo Lab* (decide hook vs skill vs CLAUDE.md-line
for a rule, brief a subagent), then tick the *Mastery checklist*. Passing M11 **closes Stage 3** — Vim,
Tmux, Git, SSH, dotfiles, and AI now compose into one workflow.

> The one-sentence takeaway: **you are the engineer of record — the config you wrote is how you keep
> that true at speed: rules the agent loads, commands it runs without asking, workflows it reuses.**

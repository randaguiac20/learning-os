# Step 3 — Scaffold .claude/ — a slash command and a skill

Instructions live in **layers**. Beyond the always-loaded CLAUDE.md, two on-demand extensions live under
`.claude/`:

- a **custom slash command** — a Markdown file in `.claude/commands/`; `$ARGUMENTS` is filled from what
  you type after the command name.
- a **skill** — `.claude/skills/<name>/SKILL.md` with YAML frontmatter naming and describing a
  sometimes-relevant workflow.

Create the slash command — a new-script scaffolder:

```bash
mkdir -p .claude/commands
```{{exec}}

```bash
cat > .claude/commands/new-tool.md <<'EOF'
---
description: Scaffold a new shell tool with our standards
argument-hint: <tool-name>
---
Create a new script named `$ARGUMENTS.sh` following `backup-lite.sh`'s getopts style.
Include a usage function, the exit-code contract, and a failure-matrix comment block.
Run `shellcheck` on it at the end and show me the output.
EOF
```{{exec}}

Now the skill — a reusable failure-matrix workflow:

```bash
mkdir -p .claude/skills/failure-matrix
```{{exec}}

```bash
cat > .claude/skills/failure-matrix/SKILL.md <<'EOF'
---
name: failure-matrix
description: Add a standard failure-matrix comment block to a shell tool and verify every path.
---
When adding a failure matrix: list each failure condition, its exit code, and the message.
Confirm `shellcheck` passes and the exit-code contract holds for every path before finishing.
EOF
```{{exec}}

See the whole structure you've built:

```bash
ls -R .claude
```{{exec}}

The **layering rule** to journal: the scaffolder is a **skill** (sometimes relevant), the lint-after-edit
would be a **hook** (never-skip, deterministic), and the exit-code contract is a **CLAUDE.md line**
(every-session fact). Escalate to a firmer layer only what earns it.

Click **Check** to verify your CLAUDE.md sections, the slash command, and the skill exist with the right
shape.

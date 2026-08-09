# Step 1 — The agent loop and the six control surfaces

Claude Code runs the **agent loop**: **observe** (results, files, errors) → **decide** (the model picks
the next action) → **act** (a tool call) → repeat, until done or a checkpoint. That is *Module 23's
debugging loop, automated* — and a flailing agent is a system with a bug (read the trail, find the wrong
DECIDE step).

Raw models with tools **flail** on real repos. What makes agency useful is the **harness** — the six
control surfaces you configure this lab around:

- **Permissions** — least privilege (M24): which tools/edits the agent may take.
- **Hooks** — deterministic guardrails wired to lifecycle events.
- **CLAUDE.md / memory** — persistent instructions (context engineering).
- **MCP** — the tool protocol: build a server once, every client uses it.
- **Subagents / SDK** — orchestration; the harness as a library.
- **Headless** — `claude -p`, the scriptable Unix citizen.

Set up a project to hold the config — it's just files, so no key is needed:

```bash
mkdir -p ~/agent-lab && cd ~/agent-lab && git init -q 2>/dev/null; ls -la
```{{exec}}

Confirm the tools this lab validates with — a shell and Python for JSON:

```bash
python3 --version
```{{exec}}

Write a scaled `CLAUDE.md` — the persistent-instruction layer, holding only **universal, non-inferable**
facts (a bloated file gets ignored):

```bash
cat > CLAUDE.md <<'EOF'
# Project: Capstone AI Service

## Commands
- Test: `./run-tests.sh`
- Lint: `shellcheck *.sh` — must pass before commit

## Conventions
- Every tool exits 0 on success, non-zero on failure (the exit-code contract).
- Secrets live in `secrets/` and are NEVER edited by the agent.
EOF
cat CLAUDE.md
```{{exec}}

**The one thing to hold onto:** you are extending an **identity**. Everything you build next either grants
it capability (MCP, subagents) or bounds it (permissions, hooks, checkpoints). Stay in `~/agent-lab` for
every remaining step.

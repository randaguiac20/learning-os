# Step 4 — A headless automation skeleton

**Headless mode** — `claude -p "…"` — makes the agent a **Unix citizen**: piped, scripted, run in CI
(Continuous Integration), scheduled. It fulfils M15's automation and M5's Unix philosophy at the AI layer.
Two flags make it safe and composable:

- `--allowedTools` — scope the unattended run to a **named allowlist** (least privilege for a robot).
- `--output-format json` — emit machine-readable output for the next pipe stage.

Write the re-indexer skeleton — an M15 fleet member. It runs with **your** key locally; in the browser VM
it is a *shape* to validate, not to execute:

```bash
cd ~/agent-lab
cat > reindex-agent.sh <<'EOF'
#!/usr/bin/env bash
# Headless re-indexer: an M15 fleet member — least-privileged, audit-hooked.
# Runs with YOUR key locally; skeleton only in the browser VM.
set -euo pipefail

claude -p "Re-index any new docs under ./docs and report new files as JSON" \
  --allowedTools "Read" "Bash(ls:*)" "Bash(git status:*)" \
  --output-format json \
  >> .claude/reindex.log
EOF
chmod +x reindex-agent.sh
```{{exec}}

Prove the script parses (syntax check only — it does **not** run the agent):

```bash
bash -n reindex-agent.sh && echo "syntax OK"
```{{exec}}

See its shape — the `claude -p`, the scoped tools, the JSON output, the append to the audit log:

```bash
cat reindex-agent.sh
```{{exec}}

The `--allowedTools` scope is the **CI-safety note** made concrete: a headless agent in CI is *a
least-privileged identity with an audit trail, or it's a liability*. It can read and list — it cannot
deploy, merge, or touch `secrets/`.

Click **Check** to verify the script exists, parses, and has the `claude -p` invocation with a scoped
`--allowedTools` allowlist.

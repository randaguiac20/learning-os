#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the headless script exists, parses, and has a
# scoped `claude -p ... --allowedTools` invocation.
proj="$HOME/agent-lab"
f="$proj/reindex-agent.sh"

[ -f "$f" ] || { echo "$f not found — write the headless skeleton in Step 4."; exit 1; }
bash -n "$f" 2>/dev/null || { echo "$f has a syntax error — fix it (bash -n must pass) (Step 4)."; exit 1; }
grep -qE 'claude[[:space:]]+-p' "$f" || { echo "$f is missing a 'claude -p' headless invocation (Step 4)."; exit 1; }
grep -qF -- '--allowedTools' "$f" || { echo "$f must scope the run with --allowedTools (least privilege for a robot) (Step 4)."; exit 1; }

echo "Verified: reindex-agent.sh exists, parses cleanly, and runs 'claude -p' with a scoped --allowedTools allowlist."
exit 0

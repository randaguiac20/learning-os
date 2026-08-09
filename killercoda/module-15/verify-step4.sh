#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the play applied its state AND is idempotent
# (a fresh run reports changed=0, failed=0).
lab="$HOME/automation-lab"
play="$lab/play.yml"
managed="$lab/managed"

[ -f "$play" ] || { echo "play.yml not found — write it in Step 4."; exit 1; }
command -v ansible-playbook >/dev/null 2>&1 || { echo "ansible-playbook not found — install ansible in Step 1."; exit 1; }

# The play must have been applied at least once (the ACTION's converged state exists).
[ -d "$managed" ] || { echo "managed/ not found — run the play once first (Step 4)."; exit 1; }
[ -f "$managed/app.conf" ] || { echo "managed/app.conf not found — run the play first (Step 4)."; exit 1; }
grep -q 'role = worker' "$managed/app.conf" || { echo "app.conf missing its managed content — re-run the play (Step 4)."; exit 1; }
[ -f "$managed/notes.txt" ] || { echo "managed/notes.txt not found — run the play first (Step 4)."; exit 1; }

# Prove IDEMPOTENCE by running the play again and asserting the recap shows no changes and no failures.
recap="$(ansible-playbook -i localhost, -c local "$play" 2>/dev/null | grep 'changed=')"
if [ -z "$recap" ]; then
  echo "Could not read a PLAY RECAP from ansible-playbook — run it manually and check for errors (Step 4)."
  exit 1
fi
if ! echo "$recap" | grep -q 'failed=0'; then
  echo "The play reported failures on re-run:"; echo "  $recap"; exit 1
fi
if ! echo "$recap" | grep -q 'changed=0'; then
  echo "The play is NOT idempotent — a fresh run still reports changes:"; echo "  $recap"
  echo "Each task must declare state, not append blindly. Re-check your play (Step 4)."
  exit 1
fi

echo "Verified: the play applied its state and a fresh run reports changed=0, failed=0 — idempotence proven by the tool."
exit 0

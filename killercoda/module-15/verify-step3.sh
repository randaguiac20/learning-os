#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the cron job is armed AND the script produced output.
lab="$HOME/automation-lab"
script="$lab/heartbeat.sh"
log="$lab/heartbeat.log"

[ -d "$lab" ] || { echo "Sandbox ~/automation-lab not found — create it in Step 1."; exit 1; }
[ -x "$script" ] || { echo "heartbeat.sh not found or not executable — create it and chmod +x it (Step 3)."; exit 1; }

# A crontab entry must reference the heartbeat script (the TRIGGER organ).
if ! crontab -l 2>/dev/null | grep -q 'heartbeat.sh'; then
  echo "No cron entry for heartbeat.sh — arm it with:"
  echo "  ( crontab -l 2>/dev/null; echo \"* * * * * \$HOME/automation-lab/heartbeat.sh\" ) | crontab -"
  exit 1
fi

# The job must have produced output (EVIDENCE) — at least one line in the log.
[ -s "$log" ] || { echo "heartbeat.log is empty — run the script by hand first: ~/automation-lab/heartbeat.sh"; exit 1; }
if ! grep -q 'heartbeat ok' "$log"; then
  echo "heartbeat.log exists but has no 'heartbeat ok' line — run the script (Step 3)."
  exit 1
fi

echo "Verified: cron is armed for heartbeat.sh and the job produced evidence in heartbeat.log. Trigger + evidence, wired."
exit 0

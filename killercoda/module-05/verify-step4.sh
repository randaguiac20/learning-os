#!/bin/bash
# Killercoda step verifier: pass when backup-lite.sh parses flags with getopts, requires -d
# (usage + non-zero exit when missing), and accepts the happy path.
s="$HOME/learning/scripts/backup-lite.sh"
[ -f "$s" ] || { echo "backup-lite.sh not found — create it in ~/learning/scripts as shown in Step 4."; exit 1; }
grep -q 'getopts' "$s" || { echo "Use getopts to parse the flags (getopts \"d:ng:h\" opt)."; exit 1; }
grep -q 'main "\$@"' "$s" || { echo "End the script with the standard entry point: main \"\$@\""; exit 1; }
if bash "$s" -n >/dev/null 2>&1; then
  echo "backup-lite.sh should refuse (non-zero exit) when required -d is missing."
  exit 1
fi
if bash "$s" -d /tmp/backup -n -g 5 >/dev/null 2>&1; then
  :
else
  echo "backup-lite.sh should succeed on the happy path: -d /tmp/backup -n -g 5"
  exit 1
fi
echo "Verified: backup-lite.sh parses flags, requires -d, and uses main \"\$@\". Real-tool shape achieved."
exit 0

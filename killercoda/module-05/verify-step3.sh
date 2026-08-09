#!/bin/bash
# Killercoda step verifier: pass (exit 0) when check-user.sh exists, has the shebang +
# set line, and reports exit codes honestly (0 for a real user, non-zero for a fake one).
s="$HOME/learning/scripts/check-user.sh"
[ -f "$s" ] || { echo "check-user.sh not found — create it in ~/learning/scripts as shown in Step 3."; exit 1; }
head -1 "$s" | grep -q '^#!/bin/bash' || { echo "First line must be the shebang: #!/bin/bash"; exit 1; }
grep -q 'set -euo pipefail' "$s" || { echo "Add the seatbelt as line 2: set -euo pipefail"; exit 1; }
if bash "$s" root >/dev/null 2>&1; then
  :
else
  echo "check-user.sh should exit 0 for an existing user (try: ./check-user.sh root)."
  exit 1
fi
if bash "$s" no-such-user-xyz >/dev/null 2>&1; then
  echo "check-user.sh should exit non-zero for a missing user (honest failure + stderr)."
  exit 1
fi
echo "Verified: check-user.sh has the shebang + set flags and reports exit codes honestly. Well done."
exit 0

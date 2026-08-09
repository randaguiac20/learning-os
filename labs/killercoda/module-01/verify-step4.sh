#!/bin/bash
# Killercoda step verifier: pass when myinfo.sh exists, is executable, and runs cleanly.
f="$HOME/myinfo.sh"
[ -f "$f" ] || { echo "myinfo.sh not found in your home directory."; exit 1; }
[ -x "$f" ] || { echo "myinfo.sh is not executable — run: chmod +x myinfo.sh"; exit 1; }
head -1 "$f" | grep -q '^#!' || { echo "myinfo.sh is missing a shebang (#!/bin/bash) on line 1."; exit 1; }
if ! "$f" >/dev/null 2>&1; then
  echo "myinfo.sh exists but exited with an error — run ./myinfo.sh and read the output."
  exit 1
fi
echo "Verified: myinfo.sh exists, is executable, has a shebang, and runs. Nicely done."
exit 0

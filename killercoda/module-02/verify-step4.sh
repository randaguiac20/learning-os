#!/bin/bash
# Killercoda step verifier: pass when the renamed file survived and the scratch files are gone.
lab="$HOME/terminal-lab"
[ -d "$lab" ] || { echo "Sandbox ~/terminal-lab not found — start from Step 3."; exit 1; }
[ -f "$lab/projects/beta/day1-copy.md" ] || { echo "projects/beta/day1-copy.md not found — copy then mv-rename it as shown in Step 4."; exit 1; }
for f in trash1 trash2 trash3; do
  if [ -e "$lab/$f" ]; then
    echo "Scratch file '$f' still exists — remove it with: rm $f  (ls first!)"
    exit 1
  fi
done
echo "Verified: day1-copy.md survived the copy+rename, and trash1..3 are gone. Verification rhythm working."
exit 0

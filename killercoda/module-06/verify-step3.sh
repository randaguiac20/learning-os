#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the text-object edits produced the target file.
f="$HOME/vim-lab/greeting.sh"
[ -f "$f" ] || { echo "greeting.sh not found — create it in ~/vim-lab and edit it as shown in Step 3."; exit 1; }

grep -q '^greeting="welcome"$' "$f" || { echo "Line 1 should be  greeting=\"welcome\"  — put the cursor inside the quotes and use  ci\"  then type welcome."; exit 1; }
grep -q '^name="friend"$' "$f"      || { echo "Line 2 should be  name=\"friend\"  — use  ci\"  inside \"stranger\" and type friend."; exit 1; }
grep -q '^run()$' "$f"              || { echo "Line 3 should be  run()  — put the cursor inside the parentheses and use  di(  to delete the argument list."; exit 1; }
grep -q 'hello'    "$f" && { echo "Still see 'hello' — did you change inside the first quotes with ci\"?"; exit 1; }
grep -q 'stranger' "$f" && { echo "Still see 'stranger' — change inside the second quotes with ci\"."; exit 1; }

echo "Verified: ci\" changed both quoted values and di( emptied the parens. Text objects working."
exit 0

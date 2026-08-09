#!/bin/bash
# Killercoda step verifier: pass (exit 0) when wordfreq.py reports 'the' as the most common word (3 times).
f="$HOME/learning/py/wordfreq.py"
[ -f "$f" ] || { echo "wordfreq.py not found — create it in ~/learning/py as shown in Step 4."; exit 1; }
out="$(python3 "$f" 2>/dev/null)" || { echo "wordfreq.py failed to run — see the traceback with: python3 $f"; exit 1; }
if echo "$out" | grep -qiE 'most common: the \(3\)'; then
  echo "Verified: wordfreq.py counts words with a dict and reports the most common — functions + a data structure working."
  exit 0
fi
echo "Expected a line like 'most common: the (3)' — got:"
echo "$out"
exit 1

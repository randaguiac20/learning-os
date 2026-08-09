#!/bin/bash
# Killercoda step verifier: pass (exit 0) when report.sh runs green and reads the right
# threshold — i.e. the missing-config root cause is fixed, not just the symptom papered over.
lab="$HOME/debug-lab"
prog="$lab/report.sh"
[ -x "$prog" ] || { echo "report.sh missing or not executable — start from Step 2."; exit 1; }
out=$("$prog" 2>&1); code=$?
if [ "$code" -ne 0 ]; then
  echo "report.sh still exits $code — it cannot find its config."
  echo "Use: strace -f -e trace=file $prog 2>&1 | grep report.conf  to see the path it opens, then put the config THERE."
  echo "--- program output ---"
  echo "$out"
  exit 1
fi
if ! echo "$out" | grep -q 'threshold=42'; then
  echo "report.sh runs, but the threshold is wrong — expected threshold=42. Output was:"
  echo "$out"
  exit 1
fi
echo "Verified: report.sh exits 0 and reads threshold=42 — the misplaced-config root cause is fixed and the fix is proven."
exit 0

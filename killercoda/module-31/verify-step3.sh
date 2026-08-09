#!/bin/bash
# Killercoda step verifier: pass when the Step 1 numerical gradient-check error is below tolerance
# AND the Step 3 die sample mean has converged near the theoretical 3.5 (law of large numbers).
lab="$HOME/mathlab"
gc="$lab/gradient_check.txt"
lln="$lab/lln.txt"
[ -f "$gc" ]  || { echo "gradient_check.txt not found — run the Step 1 numerical-derivative block first."; exit 1; }
[ -f "$lln" ] || { echo "lln.txt not found — run the Step 3 sampling block."; exit 1; }
err=$(cat "$gc")
awk -v e="$err" 'BEGIN { if (e+0 < 1e-3) exit 0; else exit 1 }' \
  || { echo "Numerical derivative error $err is too large — expected < 1e-3. Re-run Step 1."; exit 1; }
mean=$(awk '{print $1}' "$lln")
awk -v m="$mean" 'BEGIN { d = m - 3.5; if (d < 0) d = -d; if (d < 0.05) exit 0; else exit 1 }' \
  || { echo "Sampled mean $mean is not within 0.05 of the theoretical 3.5 — re-run Step 3 (keep n large)."; exit 1; }
echo "Verified: gradient-check error $err < 1e-3, and the die's sample mean $mean approaches 3.5 (law of large numbers)."
exit 0

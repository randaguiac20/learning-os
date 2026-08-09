#!/bin/bash
# Killercoda step verifier: pass when the gradient-descent run drove the final loss below threshold.
proj="$HOME/ai-foundations"
threshold="0.05"
[ -f "$proj/gd.py" ]   || { echo "gd.py not found — create it in ~/ai-foundations as shown in Step 4."; exit 1; }
[ -f "$proj/loss.txt" ] || { echo "loss.txt not found — run: cd ~/ai-foundations && python3 gd.py"; exit 1; }
loss=$(tr -d '[:space:]' < "$proj/loss.txt")
case "$loss" in
  ''|*[!0-9.]*) echo "loss.txt does not contain a number ('$loss') — re-run: cd ~/ai-foundations && python3 gd.py"; exit 1 ;;
esac
if awk -v l="$loss" -v t="$threshold" 'BEGIN { exit !(l < t) }'; then
  echo "Verified: gradient descent drove the loss to $loss (< $threshold). You trained a model — the curve fell."
  exit 0
fi
echo "Final loss is $loss, not below $threshold — the line hasn't fit yet. Keep lr=0.5 and 200 steps, then re-run: python3 gd.py"
exit 1

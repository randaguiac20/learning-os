#!/bin/bash
# Killercoda step verifier: pass when the Bayes posterior P(disease|positive) matches the expected ~0.083.
lab="$HOME/mathlab"
b="$lab/bayes.txt"
[ -f "$b" ] || { echo "bayes.txt not found — run the Step 4 Bayes block."; exit 1; }
post=$(cat "$b")
awk -v p="$post" 'BEGIN { d = p - 0.0833; if (d < 0) d = -d; if (d < 0.01) exit 0; else exit 1 }' \
  || { echo "Posterior $post does not match the expected ~0.083 — check prevalence/tpr/fpr in Step 4."; exit 1; }
echo "Verified: P(disease | positive) = $post is about 0.083 — the base rate dominates, exactly the mammogram result."
exit 0

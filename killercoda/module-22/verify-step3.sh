#!/bin/bash
# Killercoda step verifier: the batching experiment produced a results file where
# per-item time falls as the batch grows (batch 512 < batch 1).
lab="$HOME/gpu-lab"
csv="$lab/batch-results.csv"
[ -f "$csv" ] || { echo "batch-results.csv not found — run: python3 ~/gpu-lab/batch.py"; exit 1; }

grep -q '^batch,total_ms,per_item_ms' "$csv" || { echo "batch-results.csv header looks wrong — re-run batch.py."; exit 1; }

first="$(awk -F, '$1==1   {print $3}' "$csv")"
last="$(awk -F, '$1==512 {print $3}' "$csv")"
[ -n "$first" ] || { echo "No batch=1 row in batch-results.csv — re-run batch.py."; exit 1; }
[ -n "$last" ]  || { echo "No batch=512 row in batch-results.csv — re-run batch.py."; exit 1; }

# per-item time at batch 512 must be strictly less than at batch 1 (the amortization curve)
awk -v a="$first" -v b="$last" 'BEGIN { exit !(b < a) }' || {
  echo "Per-item time did not fall (batch1=$first ms, batch512=$last ms) — the batching effect should shrink it. Re-run batch.py."
  exit 1
}

echo "Verified: per-item time fell from ${first} ms (batch 1) to ${last} ms (batch 512) — the fixed cost amortized. Same curve GPUs live on."
exit 0

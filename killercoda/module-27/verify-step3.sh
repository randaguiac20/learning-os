#!/bin/bash
# Killercoda step verifier: pass (exit 0) when a real trained model wrote metrics.json,
# its test accuracy clears a sane bar, AND the train/test split was honest (no overlap).
lab="$HOME/ml-lab"
mf="$lab/metrics.json"
[ -f "$mf" ] || { echo "metrics.json not found in ~/ml-lab — run: python3 train.py"; exit 1; }

python3 - "$mf" <<'PY'
import json, sys
try:
    m = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse metrics.json:", e); sys.exit(1)

acc = m.get("test_accuracy")
overlap = m.get("train_test_overlap")

if acc is None or overlap is None:
    print("metrics.json is missing 'test_accuracy' or 'train_test_overlap' — re-run train.py."); sys.exit(1)

# Honesty first: the model must not have trained on any test row.
if overlap != 0:
    print(f"LEAKAGE: {overlap} rows appear in BOTH train and test. The split is not honest — re-run the shipped train.py."); sys.exit(1)

# A real, honestly-evaluated logistic regression on digits clears ~0.90.
if acc < 0.90:
    print(f"Test accuracy {acc} is below the 0.90 bar — the model did not train correctly. Re-run train.py."); sys.exit(1)

print(f"Verified: honest split (0 overlap) and test accuracy {acc} >= 0.90. That number is real.")
PY

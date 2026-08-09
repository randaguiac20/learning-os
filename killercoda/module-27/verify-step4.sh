#!/bin/bash
# Killercoda step verifier: pass (exit 0) when overfit.json shows a real overfitting gap
# (an unbounded tree memorized the training set) AND regularization reduced that gap.
lab="$HOME/ml-lab"
of="$lab/overfit.json"
[ -f "$of" ] || { echo "overfit.json not found in ~/ml-lab — run: python3 overfit.py"; exit 1; }

python3 - "$of" <<'PY'
import json, sys
try:
    r = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse overfit.json:", e); sys.exit(1)

need = ["overfit_train_accuracy", "overfit_gap", "fixed_gap"]
if any(r.get(k) is None for k in need):
    print("overfit.json is missing expected fields — re-run overfit.py."); sys.exit(1)

o_train = r["overfit_train_accuracy"]
o_gap   = r["overfit_gap"]
f_gap   = r["fixed_gap"]

# The unbounded tree should have essentially memorized the training set.
if o_train < 0.99:
    print(f"The unbounded tree's train accuracy is {o_train} (<0.99) — it did not overfit as expected. Re-run overfit.py."); sys.exit(1)

# That memorization must show up as a large generalization gap.
if o_gap < 0.10:
    print(f"Overfit gap {o_gap} is too small (<0.10) — no dragon to see. Re-run the shipped overfit.py."); sys.exit(1)

# Regularization (capping depth) must have shrunk the gap.
if not (f_gap < o_gap):
    print(f"The cure did not help: fixed gap {f_gap} is not smaller than overfit gap {o_gap}. Re-run overfit.py."); sys.exit(1)

print(f"Verified: the unbounded tree overfit (train {o_train}, gap {o_gap}); capping depth cut the gap to {f_gap}. Dragon met and tamed.")
PY

#!/bin/bash
# Killercoda step verifier: pass when the classifier cleared the held-out accuracy bar and wrote metrics.
cd "$HOME/nlp-lab" 2>/dev/null || { echo "~/nlp-lab not found — start from Step 1."; exit 1; }
[ -f metrics.json ] || { echo "metrics.json not found — run: python3 classify.py"; exit 1; }
python3 - <<'PY' || exit 1
import json, sys
m = json.load(open("metrics.json"))
acc = m.get("accuracy")
n = m.get("n_test")
f1 = m.get("f1_macro")
if n != 4:
    print(f"expected 4 held-out sentences, got n_test={n} — use the TEST set from corpus.py"); sys.exit(1)
if acc is None or acc < 0.75:
    print(f"held-out accuracy {acc} is below the 0.75 bar — retrain / check the corpus and vectorizer"); sys.exit(1)
if f1 is None:
    print("metrics.json is missing 'f1_macro' — report F1 alongside accuracy"); sys.exit(1)
print(f"Verified: classifier scored accuracy={acc:.3f}, macro-F1={f1:.3f} on {n} held-out sentences (bar 0.75).")
PY
exit 0

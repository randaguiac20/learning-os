# Step 4 — Bayes: the mammogram shock

**Bayes' theorem** updates a belief with evidence: `P(H|E) = P(E|H)·P(H) / P(E)` — posterior =
likelihood × prior / evidence. The classic shock: a test **90% accurate** for a disease affecting **1%**
of people returns positive. What's the chance you actually have it?

Compute `P(disease | positive)` with Bayes, then simulate 100,000 patients to confirm:

```bash
cd ~/mathlab
```{{exec}}

```bash
python3 - <<'PY'
import numpy as np
prev, tpr, fpr = 0.01, 0.90, 0.10         # prevalence, true-positive rate, false-positive rate
post = tpr*prev / (tpr*prev + fpr*(1-prev))
print(f"P(disease | positive) = {post:.4f}  (~{post*100:.1f}%)")
rng = np.random.default_rng(31)
N = 100_000
sick = rng.random(N) < prev
positive = np.where(sick, rng.random(N) < tpr, rng.random(N) < fpr)
print(f"simulated over {N:,} patients: {sick[positive].mean():.4f}")
open("bayes.txt", "w").write(f"{post:.4f}\n")
PY
```{{exec}}

**~8.3%, not 90%.** Despite "90% accuracy," a positive result is ~92% likely a false alarm — because the
disease is rare, the **base rate** (prior prevalence) dominates. The simulation confirms the math.

This IS M27's **precision** under class imbalance: `precision = P(real | flagged) = Bayes`, and "90%
accurate" is meaningless without the base rate. The same math explains alert fatigue in security (M24/M25):
a "99% accurate" intrusion detector on rare attacks drowns you in false positives.

Click **Check** to verify the posterior matches the expected value.

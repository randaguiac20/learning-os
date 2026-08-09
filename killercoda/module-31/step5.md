# Step 5 — A confidence interval and a p-value

A test-set metric is a **sample**, not a truth — so it carries a **confidence interval** (point estimate
± margin, the margin from the standard error). Comparing two models is a **hypothesis test**: is the gap
real, or noise?

Two models on one 500-example test set: A at 92% (460/500), B at 94% (470/500). Put a CI on each, then
run a **two-proportion test** on the difference. We get the normal-approximation p-value from
`math.erf` — no statistics library needed:

```bash
cd ~/mathlab
```{{exec}}

```bash
python3 - <<'PY'
import math
def ci(correct, n, z=1.96):
    p = correct/n
    return p, z*math.sqrt(p*(1-p)/n)                  # point estimate, 95% margin
def two_prop_p(cA, nA, cB, nB):
    pA, pB = cA/nA, cB/nB
    pool = (cA+cB)/(nA+nB)
    se = math.sqrt(pool*(1-pool)*(1/nA + 1/nB))
    z = (pB-pA)/se
    return z, 2*(1 - 0.5*(1+math.erf(abs(z)/math.sqrt(2))))   # two-sided p-value
nA = nB = 500
(pA,hA), (pB,hB) = ci(460,nA), ci(470,nB)
print(f"Model A: {pA*100:.1f}% +/- {hA*100:.1f}%")
print(f"Model B: {pB*100:.1f}% +/- {hB*100:.1f}%")
z, p = two_prop_p(460,nA,470,nB)
print(f"difference test: z = {z:.2f}   p = {p:.3f}")
print("verdict:", "significant" if p < 0.05 else "NOT significant — the +2% is within noise")
PY
```{{exec}}

The two intervals **overlap** and `p ≈ 0.22` — the 2% gap is **not significant** on 500 examples. "B is
better" was a claim the point estimates couldn't carry; the interval and the test say so honestly. That
is M27's model comparison, made statistical.

A **p-value** IS `P(data at least this extreme | the null is true)` — it is NOT the probability the null
is true, and NOT the effect size. And beware **p-hacking**: test 20 hypotheses on noise and ~1 comes out
"significant" by construction (`20 × 0.05 = 1`) — the same discipline as M27's touch-the-test-set-once.

You've now run both instruments: the accelerator (calculus — gradient descent) and the speedometer with
error bars (statistics — the CI and the test). That's Module 31, hands-on.

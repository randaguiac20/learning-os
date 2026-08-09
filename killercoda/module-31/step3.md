# Step 3 — The law of large numbers

A **random variable** takes values with probabilities set by a **distribution**. Its **expectation**
(the mean `μ`) is the long-run average; its **variance** (`σ²`) is the spread. The **law of large
numbers** says: average enough samples and the empirical mean converges to the expectation.

Roll a fair six-sided die many times. Theory: the mean is `3.5` and the variance is `35/12 ≈ 2.9167`.
Watch the empirical numbers land on them:

```bash
cd ~/mathlab
```{{exec}}

```bash
python3 - <<'PY'
import numpy as np
rng = np.random.default_rng(31)           # pinned seed -> reproducible
n = 200_000
rolls = rng.integers(1, 7, size=n)        # fair six-sided die: values 1..6
mean, var = rolls.mean(), rolls.var()
print(f"n = {n:,}  empirical mean = {mean:.4f}  (theory 3.5000)")
print(f"            empirical var = {var:.4f}  (theory 2.9167)")
open("lln.txt", "w").write(f"{mean:.4f} {var:.4f}\n")
PY
```{{exec}}

The empirical mean sits within a whisker of `3.5` and the variance near `2.9167` — not by luck, but
because averaging many independent draws *forces* convergence. This is also why bigger test sets give
tighter estimates (M27): the spread of a sample mean shrinks as `1/√n`.

Click **Check** to verify two artifacts at once: the Step 1 gradient-check error is below tolerance, and
the die's sample mean has converged to within a band of the theoretical `3.5`.

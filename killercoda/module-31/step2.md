# Step 2 — Gradient descent, from scratch

Gradient descent is THE training algorithm (M26), and it's old — Cauchy published it in **1847**. To
*minimize* a function, step **opposite** its gradient (downhill): `θ ← θ − η∇L`, where `η` (eta) is the
**learning rate** — the step size.

Minimize `f(x) = (x − 4)²` (minimum at `x = 4`). Its gradient is `f'(x) = 2(x − 4)`. Run three learning
rates and watch the three regimes the calculus predicts:

```bash
cd ~/mathlab
```{{exec}}

```bash
python3 - <<'PY'
import numpy as np
grad = lambda x: 2*(x-4)                  # d/dx (x-4)^2
def descend(eta, steps=100, x0=0.0):
    x = x0
    for _ in range(steps):
        x = x - eta*grad(x)               # theta <- theta - eta * gradient
    return x
for eta in [0.01, 0.1, 1.01]:
    print(f"eta={eta:<5} final x = {descend(eta):.4f}")
x_good = descend(0.1)
open("gd.txt", "w").write(f"{x_good:.4f}\n")
print(f"converged x = {x_good:.4f}  (true minimum at x = 4)")
PY
```{{exec}}

Read the three lines:

- `η = 0.1` lands on **4.0000** — **converged** (just right).
- `η = 0.01` stops short of 4 — **crawl** (too small; it would arrive eventually, but slowly).
- `η = 1.01` explodes to a huge number — **diverge** (too big; the step overshoots and the curvature
  throws it higher).

That divergence is the **calculus, not a code bug**: the step is larger than the surface's curvature can
absorb. When a real training run diverges, this is almost always the cause — reduce `η`, don't rewrite
the model. This is M26's "learning rate" knob, now explained from the derivative up.

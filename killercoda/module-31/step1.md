# Step 1 — The derivative, felt as a limit

The **derivative** `f'(x)` is the instantaneous rate of change of `f` — the slope of its tangent line.
It's defined as a *limit*: `f'(x) = lim (h → 0) of (f(x+h) − f(x)) / h`. You can *feel* that limit by
computing it numerically for a tiny `h` and watching it match the answer you get by the rules.

First, set up the bench — a working directory and numpy:

```bash
mkdir -p ~/mathlab && cd ~/mathlab
```{{exec}}

```bash
apt-get update -y && apt-get install -y python3-pip && pip install numpy
```{{exec}}

Now compute the derivative of `f(x) = x²` two ways. The **analytic** derivative is `f'(x) = 2x`, so
`f'(3) = 6`. The **numerical** one uses the symmetric difference quotient `(f(x+h) − f(x−h)) / (2h)`:

```bash
python3 - <<'PY'
import numpy as np
f = lambda x: x**2                       # f(x) = x^2
h, x = 1e-5, 3.0
numeric  = (f(x+h) - f(x-h)) / (2*h)     # symmetric difference quotient
analytic = 2*x                           # f'(x) = 2x  ->  6
err = abs(numeric - analytic)
print(f"numerical f'(3) = {numeric:.6f}")
print(f"analytic  f'(3) = {analytic:.6f}")
print(f"abs error       = {err:.2e}")
open("gradient_check.txt", "w").write(f"{err:.3e}\n")
PY
```{{exec}}

The absolute error is tiny (~1e-10). The derivative isn't a formula to memorize — it's a **limit you can
watch converge**. This exact check — a hand/analytic derivative against a numerical one — is the
**gradient-check habit** you first met in M26; you'll reuse it whenever a derivative "looks wrong."

The error you just saved (`gradient_check.txt`) is verified in Step 3.

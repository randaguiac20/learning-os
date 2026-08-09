# Step 4 — Gradient descent — watch the loss fall

Now *train* a model: fit a line to ten noisy points by gradient descent — no library, just the chain rule by
hand. The loss is mean squared error (how wrong), and you nudge the slope and intercept downhill each step.

Create `gd.py`:

```bash
cat > ~/ai-foundations/gd.py <<'PY'
import numpy as np
rng = np.random.default_rng(0)
x = np.linspace(0, 1, 10)
y = 2.0 * x + 1.0 + rng.normal(0, 0.05, size=10)   # ~ y = 2x + 1, plus noise

w, b = 0.0, 0.0                                     # start knowing nothing
lr = 0.5                                            # the learning-rate knob
for step in range(200):
    yhat = w * x + b
    err = yhat - y
    loss = float(np.mean(err**2))                  # mean squared error
    grad_w = float(np.mean(2 * err * x))           # chain rule, by hand
    grad_b = float(np.mean(2 * err))
    w -= lr * grad_w                               # nudge downhill
    b -= lr * grad_b
    if step % 40 == 0:
        print(f"step {step:3d}  loss={loss:.4f}  w={w:.3f}  b={b:.3f}")

final_loss = float(np.mean((w * x + b - y) ** 2))
print(f"final: loss={final_loss:.4f}  w={w:.3f}  b={b:.3f}  (true w=2, b=1)")
with open("loss.txt", "w") as f:
    f.write(f"{final_loss:.6f}\n")                  # the measured number
PY
```{{exec}}

Train it:

```bash
cd ~/ai-foundations && python3 gd.py
```{{exec}}

The loss falls, `w` climbs toward 2 and `b` toward 1 — gradient descent *found* the line without being told
it. **Predict first, then experiment** (Module 21's ritual): re-run with the learning rate broken and read
the curve.

```bash
cd ~/ai-foundations && sed 's/^lr = 0.5/lr = 5.0/' gd.py | python3 -   # too big -> explodes (inf/nan)
```{{exec}}

```bash
cd ~/ai-foundations && sed 's/^lr = 0.5/lr = 0.01/' gd.py | python3 -  # too small -> geology
```{{exec}}

That blow-up is training's classic failure: too large a learning rate overshoots, weights grow each step,
loss explodes to `inf`/`nan`. The fix is always to *reduce* it. Those runs also rewrote `loss.txt` with a
bad number, so restore the good fit before checking:

```bash
cd ~/ai-foundations && python3 gd.py
```{{exec}}

Click **Check** to verify the final loss fell below threshold.

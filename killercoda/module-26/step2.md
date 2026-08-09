# Step 2 — Words as vectors

An **embedding** is meaning made into geometry: every word becomes a vector, and related words sit close
together. Real embeddings have hundreds of *learned* dimensions — here we hand-type four interpretable ones
so you can see the idea plainly.

Create `words.py`:

```bash
cat > ~/ai-foundations/words.py <<'PY'
import numpy as np
# Each word is a hand-made vector over 4 interpretable features:
# [is_living, is_royal, can_fly, is_vehicle]
words = {
    "king":  np.array([0.95, 0.90, 0.00, 0.00]),
    "queen": np.array([0.95, 0.85, 0.00, 0.00]),
    "dog":   np.array([0.90, 0.00, 0.00, 0.00]),
    "cat":   np.array([0.85, 0.00, 0.00, 0.00]),
    "car":   np.array([0.00, 0.00, 0.00, 0.90]),
    "jet":   np.array([0.00, 0.00, 0.80, 0.95]),
}
if __name__ == "__main__":
    for w, v in words.items():
        print(f"{w:5} -> {v}")
PY
```{{exec}}

See the vectors:

```bash
cd ~/ai-foundations && python3 words.py
```{{exec}}

**Journal:** just by reading the numbers, which two words do you expect to be *nearest*? `king` and `queen`
share the living + royal features; `car` and `jet` share the vehicle feature. Next step, you'll measure it
instead of guessing.

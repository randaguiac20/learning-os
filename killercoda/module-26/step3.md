# Step 3 — Similarity by hand — the nearest word

**Cosine similarity** is the cosine of the angle between two vectors: `a·b / (|a||b|)`. Near 1 means the
vectors point the same way — the two items are related. You'll write that line yourself, no black-box
helper.

Create `cosine.py`:

```bash
cat > ~/ai-foundations/cosine.py <<'PY'
import numpy as np
from words import words

def cosine(a, b):                                   # YOUR own line
    return float(a @ b / (np.linalg.norm(a) * np.linalg.norm(b)))

query = "king"
scores = {w: cosine(words[query], words[w]) for w in words if w != query}
for w, s in sorted(scores.items(), key=lambda kv: -kv[1]):
    print(f"  cos({query}, {w:5}) = {s:.3f}")
best = max(scores, key=scores.get)
print(f"nearest to '{query}': {best}")
with open("nearest.txt", "w") as f:
    f.write(best + "\n")                            # the artifact the verifier checks
PY
```{{exec}}

Run it:

```bash
cd ~/ai-foundations && python3 cosine.py
```{{exec}}

You just built RAG's whole trick, naked: embed everything, rank by cosine, take the top match. `king` should
land nearest `queen`. **Journal:** which line does the actual "understanding" here — and is it math or
magic?

Click **Check** to verify the nearest word was found and written.

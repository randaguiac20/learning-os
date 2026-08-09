# Step 3 — Measure the batching effect (numpy)

Batching is the GPU's oxygen — and you can **measure the exact curve on a CPU**, because a fixed cost
(reading the weights) amortizes across the batch. Install numpy:

```bash
pip install numpy >/dev/null 2>&1 || pip3 install numpy >/dev/null 2>&1 || sudo apt-get install -y python3-numpy >/dev/null 2>&1
```{{exec}}

Write the experiment. Each **forward pass reads every weight once** — a fixed cost paid whether you have
one sample or a thousand (exactly the napkin law's *model bytes*) — then does the per-sample compute. Time
it at growing batch sizes:

```bash
cd ~/gpu-lab && cat > batch.py <<'EOF'
import time, numpy as np
# The "weights": read once per forward pass — the FIXED cost (the napkin law's model bytes),
# batch-independent, and larger than cache so it streams from RAM every call.
W  = np.random.rand(4096, 4096).astype(np.float32)   # ~67 MB of weights
Dc = 256
Wc = np.random.rand(Dc, Dc).astype(np.float32)       # the per-sample compute
reps = 20
rows = []
print(f"weights = {W.nbytes/1e6:.0f} MB, read once per forward pass (the fixed cost)\n")
for B in (1, 8, 64, 512):
    X = np.random.rand(B, Dc).astype(np.float32)
    _ = W.sum(); _ = X @ Wc                          # warmup
    t0 = time.perf_counter()
    for _ in range(reps):
        _ = W.sum()      # fetch every weight once — batch-INDEPENDENT (the weight tax)
        Y = X @ Wc       # per-sample compute — scales WITH the batch
    total = (time.perf_counter() - t0) / reps
    per_item = total / B
    rows.append((B, total, per_item))
    print(f"batch={B:4d}  total={total*1e3:8.3f} ms  per-item={per_item*1e3:.5f} ms")
with open("batch-results.csv", "w") as f:
    f.write("batch,total_ms,per_item_ms\n")
    for B, total, per_item in rows:
        f.write(f"{B},{total*1e3:.5f},{per_item*1e3:.6f}\n")
print("\nwrote batch-results.csv")
EOF
```{{exec}}

Run it:

```bash
python3 batch.py
```{{exec}}

Look at the two columns: **total** time barely moves (the fixed weight-read dominates), but **per-item**
time *plummets* — often 100×+ from batch 1 to batch 512. That is the napkin law in miniature: batch-1 pays
the whole weight-read for a single result; batch-512 shares it across 512. A starved GPU at batch-1 wastes
the machine the same way — which is why serving fleets batch hard, and why *"tokens/s ≈ bandwidth ÷ model
bytes"* only improves with batching.

```bash
cat batch-results.csv
```{{exec}}

Click **Check** to verify `batch-results.csv` shows per-item time decreasing from batch 1 to batch 512.

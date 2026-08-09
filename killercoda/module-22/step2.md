# Step 2 — Arithmetic intensity & the roofline

A kernel's **arithmetic intensity** is FLOPs ÷ bytes moved. Compare it to the machine's **ridge point**
(compute roof ÷ bandwidth) and you know its ceiling: below the ridge it is **memory-bound** (bandwidth is
the limit), above it **compute-bound** (FLOP/s is the limit).

Write the classifier:

```bash
cd ~/gpu-lab && cat > ai.py <<'EOF'
# Roofline classifier — pure arithmetic, no GPU needed.
# A model H100-class machine: 2 TB/s HBM, 100 TFLOP/s compute.
BW    = 2_000e9      # bytes/s  (2 TB/s HBM)
PEAK  = 100e12       # FLOP/s   (100 TFLOP/s)
RIDGE = PEAK / BW    # FLOP/byte where the two roofs cross

def classify(name, flops, bytes_moved):
    ai = flops / bytes_moved
    verdict = "MEMORY-BOUND" if ai < RIDGE else "COMPUTE-BOUND"
    print(f"{name:14s} intensity={ai:8.2f} FLOP/byte -> {verdict}")

print(f"ridge point = {RIDGE:.1f} FLOP/byte\n")
# SAXPY: y = a*x + y  -> 2 FLOP, reads x,y writes y = 12 bytes (FP32)
classify("saxpy",       2,                       12)
# LLM decode: read every weight once (2 bytes FP16) for ~2 FLOP each
classify("llm_decode",  2,                       2)
# Big matmul N=4096: 2*N^3 FLOPs on 3*N^2 * 4 bytes
N = 4096
classify("matmul_4096", 2*N**3,                  3*N*N*4)
EOF
```{{exec}}

Run it:

```bash
python3 ai.py
```{{exec}}

Read the verdict: **saxpy** and **llm_decode** sit far below the ridge — memory-bound, bandwidth is their
ceiling (this is *why* LLM inference is memory-bound). **matmul_4096** towers above it — compute-bound,
the one workload where every GPU feature aligns.

Now prove that **size** decides. Re-run with a small matmul and watch it fall below the ridge:

```bash
sed 's/^N = 4096/N = 64/' ai.py | python3 -
```{{exec}}

Small matmul (N=64) is memory-bound too — intensity ≈ N/6. That is why a matmul is only "GPU-shaped" once
it's big enough.

Click **Check** to verify your classifier runs and labels the kernels correctly.

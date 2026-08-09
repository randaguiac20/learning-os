# Step 5 — The transfer tax: compute the break-even

A GPU only wins if the compute it saves beats the cost of **shipping the data across PCIe**. Compute the
crossover size for a matmul — pure arithmetic, no silicon:

```bash
cd ~/gpu-lab && cat > breakeven.py <<'EOF'
# Should this matmul go to the GPU? Compare CPU-only vs GPU (transfer + compute).
CPU    = 500e9     # FLOP/s  (fast numpy on CPU)
GPU    = 20e12     # FLOP/s  (device compute)
PCIE   = 16e9      # bytes/s (host<->device)
LAUNCH = 1e-5      # s, fixed kernel-launch overhead

print(f"{'N':>6} {'cpu_ms':>9} {'gpu_ms':>9} {'transfer_ms':>12}  winner")
crossover = None
for N in (64, 128, 256, 512, 1024, 2048, 4096, 8192):
    flops = 2 * N**3
    bytes_moved = 3 * N*N * 4          # ship A, B, and C back (FP32)
    cpu = flops / CPU
    gpu = flops / GPU + bytes_moved / PCIE + LAUNCH
    win = "GPU" if gpu < cpu else "CPU"
    if win == "GPU" and crossover is None:
        crossover = N
    print(f"{N:6d} {cpu*1e3:9.3f} {gpu*1e3:9.3f} {bytes_moved/PCIE*1e3:12.3f}  {win}")
print(f"\ncrossover: the GPU first wins at N = {crossover}")
EOF
```{{exec}}

Run it:

```bash
python3 breakeven.py
```{{exec}}

Read the table top to bottom. At small `N` the **CPU wins** — the tiny compute can't repay the PCIe
shipping + launch cost; the CPU finishes before the GPU's data even arrives. Above the crossover the GPU's
throughput dominates. That single crossover number is the **transfer tax** made concrete, and it is why
*"we have a GPU"* never means *"use the GPU."* Small, chatty workloads lose **before** they compute — the
rule is move data once, keep it resident, batch the work.

```bash
python3 breakeven.py | tail -1
```{{exec}}

Click **Check** to verify `breakeven.py` prints a crossover and that the small sizes favor the CPU.

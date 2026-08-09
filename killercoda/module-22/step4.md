# Step 4 — Read nvidia-smi like an instrument

There's no GPU here, so read a **saved sample** — the same skill, offline. `nvidia-smi` is the GPU's
`top`; the four vital signs are **utilization**, **memory**, **power**, and **temperature**. Create the
sample:

```bash
cd ~/gpu-lab && cat > nvidia-smi-sample.txt <<'EOF'
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 550.54      Driver Version: 550.54      CUDA Version: 12.4        |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  NVIDIA A100-80GB    On   | 00000000:07:00.0 Off |                    0 |
| N/A   38C    P0    71W / 400W |   2048MiB / 81920MiB |     18%      Default |
+-------------------------------+----------------------+----------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name            GPU Memory Usage |
|    0   N/A  N/A     31337      C   python train.py             2046MiB      |
+-----------------------------------------------------------------------------+
EOF
```{{exec}}

```bash
cat nvidia-smi-sample.txt
```{{exec}}

Diagnose from the four vital signs:

- **Utilization 18%** — low.
- **Power 71W / 400W** — far under the cap.
- **Memory 2048 MiB / 81920 MiB** — nearly empty.
- **Temp 38C** — cool, no throttling.
- **Processes** — `python train.py` *is* on the GPU, so this is **not** a silent CPU fallback.

The verdict: util low + power far under cap = **starvation**. The GPU is being fed too slowly. The lesson
this module drills: *low utilization is a **data-pipeline** symptom.* M21's ladder owns the fix — profile
the **host** (disk? decode? single-threaded transform?), not the GPU. Contrast the failure signatures:

- **No process listed** → silent CPU fallback (check `tensor.device`).
- **Memory at the ceiling** → OOM risk (the batch-size retreat is first aid).
- **Temp high, clocks dropping** → thermal throttling.

> On a real NVIDIA box: run `nvidia-smi` live during the job, and `nvidia-smi dmon` for the time series —
> the columns you just read are exactly the same.

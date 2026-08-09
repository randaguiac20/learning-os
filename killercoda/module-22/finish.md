# Done — you can size silicon now, no GPU required

In ~30 minutes, on a plain CPU VM, you:

- Named the **two philosophies** — the CPU avoids latency (caches); the GPU hides it (oversubscribed
  warps) — and the one question that decides everything: *is my workload wide and regular?*
- Classified kernels on the **roofline** — saxpy and LLM-decode memory-bound, a big matmul compute-bound —
  and saw that a matmul is only "GPU-shaped" once it's big enough.
- **Measured** the batching effect with numpy: per-item time fell as the batch grew — the napkin law in
  miniature, the same curve serving fleets live on.
- Read a saved **nvidia-smi** sample and diagnosed **starvation** (low util + low power = a *data-pipeline*
  problem, M21's ladder owns the fix), distinguishing it from CPU fallback, OOM, and throttling.
- Computed the **transfer break-even** — why small, chatty workloads lose before they compute, and
  *"we have a GPU"* never means *"use the GPU."*

**Run it for real:** on your own NVIDIA box (or a cloud spot GPU — M37), the live `nvidia-smi`, CUDA, and
vLLM produce real numbers — and now they *mean* something. The reasoning is portable; the silicon just
relocates the curves.

**Back on the lesson page:** do the *Solo Lab* (size three models cold, assign silicon to three
workloads), the *Self-Check*, and the *Mastery checklist*. When every box is honestly true, you've closed
**Stage 7** and Module 23 (Debugging & Troubleshooting Methodology) becomes current.

> The one-sentence takeaway: **M22 completes the hardware arc begun in M1 — the throughput machine
> understood, measured, and sized — so the AI stage ahead runs on arithmetic instead of faith.**

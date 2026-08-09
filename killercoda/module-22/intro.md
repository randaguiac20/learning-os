# GPU & NPU Performance — hands-on (no GPU required)

The terminal on the right is a plain Linux CPU VM. It has **no GPU** — and it doesn't need one. Everything
a GPU is *good at* reduces to arithmetic you can compute anywhere: how much data moves, how many FLOPs,
and how a fixed cost amortizes over a batch. A GPU just relocates the same curves, larger.

In the next few minutes you will:

- classify kernels on the **roofline** (memory-bound vs compute-bound) with a Python script you write,
- **measure** the batching effect with numpy — per-item time falls as the batch grows, the same curve
  serving fleets live on,
- read a saved **nvidia-smi** sample and interpret the four vital signs,
- compute the host↔device **transfer break-even** — why "we have a GPU" never means "use the GPU."

Everything lives in a throwaway `~/gpu-lab/` directory. The live CUDA / `nvidia-smi` / vLLM path is
signposted for when you have real silicon.

> Tip: **type every command yourself** — the sizing and roofline arithmetic is the skill; running it by
> hand is how the memory forms.

Click **START** to begin.

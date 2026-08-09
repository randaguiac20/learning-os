# Step 5 — The real-GPU path (framing)

Your gateway, queue, and batcher are the exact shapes production servers implement — in CUDA, at token
granularity, with **PagedAttention** managing the KV cache. The tiers you'd reach for with a GPU:

```bash
echo "Local GPU tier : llama.cpp  -m model.gguf --server   (GGUF, CPU+GPU hybrid, modest concurrency)"
echo "Throughput tier: vllm serve <model>                  (CUDA, continuous batching + PagedAttention)"
echo "Same wire      : both speak the OpenAI-compatible API — your client scripts DON'T change"
```{{exec}}

The key move: on a GPU box you swap `forward()` for a real model server behind the **same** `/predict`,
and `bench.py` runs unchanged. That is the whole value of the wire protocol — the tier becomes an
implementation detail.

What changes with a real accelerator:

- The batch window becomes **continuous batching** — sequences join and leave the running batch **per
  decode step** instead of waiting for a fixed window; the **knee** moves right.
- The fixed cost becomes the real **weight stream** (the napkin law: tokens/s ≈ bandwidth ÷ model bytes).
- The KV cache is paged in fixed blocks — **M1's virtual memory**, recovering fragmentation for 2–4×
  throughput.

Where to actually run a GPU:

```bash
echo "Run locally with a GPU : any CUDA box — install vllm, point the gateway at it"
echo "Cloud spot GPU (M37)   : rent an accelerator by the hour; the napkin extrapolates the numbers"
echo "The degradation ledger : write down what ran CPU-only here, and what it would do on real silicon"
```{{exec}}

You built the stage on CPU; the GPU only makes the same curves larger. Click **START** (or continue) to
finish.

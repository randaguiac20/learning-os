# Done — you turned a model into a service

In ~30 minutes you:

- Installed a serving stack (**FastAPI + uvicorn**) and made a project — no GPU required.
- Built an **inference gateway** with a `/healthz` liveness probe and a `/predict` endpoint, and served a
  tiny deterministic CPU "model".
- **Hit it with curl** and verified a known input returns the correct output — the JSON-over-HTTP wire
  shape a real LLM server answers.
- Added **dynamic batching** — a queue + a background batcher that groups requests into one forward pass —
  and **measured throughput vs latency** with your own benchmark.
- Watched the law happen: **throughput is bought with batching; latency pays** — and saw where the
  real-GPU tiers (llama.cpp, vLLM, PagedAttention) plug in behind the *same* endpoints.

**Back on the lesson page:** do the *Self-Check* (recall + the "one chef, many tables" teach-back), then
the *Solo Lab* — sweep the batch to find the **knee**, compute the serving equation for a real model,
induce and defend the **death spiral**, and price cost per million tokens. Tick the *Mastery checklist*
honestly, cold.

> The one-sentence takeaway: **AI infrastructure is where the whole curriculum reports for duty — the OS's
> paging saves the GPU's memory, the network's retry discipline prevents the queue's collapse, and the
> napkin law from Module 22 turns out to have been the business plan all along.** M29 gives this service
> hands and a voice, and the final gate closes there.

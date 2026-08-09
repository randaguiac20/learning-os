# AI Infrastructure — serve a model, then batch it

You have a real Linux machine on the right. In the next few minutes you'll turn a "model" into a
**service**: build a **FastAPI inference gateway**, give it a `/healthz` check and a `/predict` endpoint,
run it with uvicorn, curl it, then add **dynamic batching** — a queue that groups requests — and
**measure throughput vs latency** with your own numbers.

**No GPU here — and that is the point.** Killercoda has no accelerator, so you'll serve a tiny
deterministic CPU "model" (`y = 2x + 1`). Every mechanism that matters — an OpenAI-style gateway, a
health check, a batch queue, the throughput-vs-latency trade — is real and measurable on CPU. The forward
pass carries a small **fixed cost paid once per batch** (standing in for the weight stream a GPU pays), so
batching amortises it exactly as it does on real silicon. When you have a GPU, swap the toy model for
**llama.cpp** or **vLLM** behind the *same* endpoints — the client scripts don't change.

The law you'll watch happen on your own screen: **throughput is bought with batching; latency pays.**

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.

Click **START** to begin.

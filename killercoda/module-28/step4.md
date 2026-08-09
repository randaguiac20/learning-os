# Step 4 — Add dynamic batching, then measure

The module's whole point. Replace the app with one that also exposes `/predict_batched`, fed by a
**queue** and a background **batcher** that groups requests and runs them as **one** forward pass —
amortising the fixed cost. A single `accel_lock` models the one shared accelerator both paths compete for:

```bash
cat > ~/ai-serve/app.py <<'PY'
import asyncio, time
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

FIXED = 0.05      # seconds paid ONCE per forward (the weight stream)
PER_ITEM = 0.002  # cheap per-item math
MAX_BATCH = 16
MAX_WAIT = 0.02   # batch window: 20 ms

accel_lock = asyncio.Lock()   # the single "accelerator" — one forward at a time

async def forward(xs):
    async with accel_lock:                       # a batch of any size = ONE weight stream
        await asyncio.sleep(FIXED + PER_ITEM * len(xs))
    return [2.0 * x + 1.0 for x in xs]

class PredictIn(BaseModel):
    x: float

queue: asyncio.Queue = asyncio.Queue()

async def batcher():
    while True:
        x, fut = await queue.get()
        batch = [(x, fut)]
        deadline = time.monotonic() + MAX_WAIT
        while len(batch) < MAX_BATCH:
            timeout = deadline - time.monotonic()
            if timeout <= 0:
                break
            try:
                batch.append(await asyncio.wait_for(queue.get(), timeout))
            except asyncio.TimeoutError:
                break
        ys = await forward([b[0] for b in batch])   # one forward for the whole group
        for (_, fut), y in zip(batch, ys):
            fut.set_result(y)

@app.on_event("startup")
async def _start():
    asyncio.create_task(batcher())

@app.get("/healthz")
def healthz():
    return {"status": "ok"}

@app.post("/predict")                 # naive: one forward per request
async def predict(req: PredictIn):
    y = (await forward([req.x]))[0]
    return {"y": y}

@app.post("/predict_batched")         # dynamic batching via the queue
async def predict_batched(req: PredictIn):
    fut = asyncio.get_event_loop().create_future()
    await queue.put((req.x, fut))
    return {"y": await fut}
PY
```{{exec}}

Restart the server on the new app:

```bash
pkill -f "uvicorn app:app" 2>/dev/null; sleep 1
cd ~/ai-serve && nohup uvicorn app:app --host 0.0.0.0 --port 8000 >/tmp/uvicorn.log 2>&1 & sleep 3
```{{exec}}

Now a benchmark (stdlib only) fires **64 concurrent** requests at each endpoint and writes the result:

```bash
cat > ~/ai-serve/bench.py <<'PY'
import json, time, urllib.request
from concurrent.futures import ThreadPoolExecutor

BASE, N, CONC = "http://localhost:8000", 64, 64

def one(path, x):
    data = json.dumps({"x": x}).encode()
    req = urllib.request.Request(BASE + path, data=data,
                                 headers={"content-type": "application/json"})
    t0 = time.time()
    with urllib.request.urlopen(req) as r:
        r.read()
    return time.time() - t0

def run(path):
    t0 = time.time()
    with ThreadPoolExecutor(max_workers=CONC) as ex:
        lats = list(ex.map(lambda i: one(path, i), range(N)))
    wall = time.time() - t0
    return {"throughput": N / wall, "avg_latency": sum(lats) / len(lats)}

out = {"requests": N, "concurrency": CONC,
       "naive": run("/predict"), "batched": run("/predict_batched")}
json.dump(out, open("results.json", "w"), indent=2)
print(f"naive   : {out['naive']['throughput']:6.1f} req/s | "
      f"avg latency {out['naive']['avg_latency']*1000:6.1f} ms")
print(f"batched : {out['batched']['throughput']:6.1f} req/s | "
      f"avg latency {out['batched']['avg_latency']*1000:6.1f} ms")
print(f"speedup : {out['batched']['throughput']/out['naive']['throughput']:.1f}x throughput")
PY
cd ~/ai-serve && python3 bench.py
```{{exec}}

Read the two lines. **Naive** serialises 64 forwards on the one accelerator (each pays the fixed cost);
**batched** groups them into ~4 forwards of 16, paying the fixed cost a quarter as often — several times
the throughput. That is the law on your screen: **throughput bought with batching**. (At *low* load the
batch window *adds* latency — that is what "latency pays" means; the win shows when the accelerator is
contended.)

Click **Check** to verify the results file exists and batched beat naive on throughput.

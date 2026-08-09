# Step 2 — Build the gateway (model + `/healthz` + `/predict`)

Write the tiny "model" and a two-endpoint gateway. `/healthz` is your liveness probe (the M25 dead-man's
check); `/predict` is the service:

```bash
cat > ~/ai-serve/app.py <<'PY'
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# The tiny deterministic "model": y = 2x + 1 (weights fixed at load).
def forward_one(x: float) -> float:
    return 2.0 * x + 1.0

class PredictIn(BaseModel):
    x: float

@app.get("/healthz")          # liveness
def healthz():
    return {"status": "ok"}

@app.post("/predict")         # the inference endpoint
def predict(req: PredictIn):
    return {"y": forward_one(req.x)}
PY
```{{exec}}

Start the server in the background and give it a moment to come up:

```bash
cd ~/ai-serve && nohup uvicorn app:app --host 0.0.0.0 --port 8000 >/tmp/uvicorn.log 2>&1 & sleep 3
```{{exec}}

Confirm it's listening (the log should say `Uvicorn running on http://0.0.0.0:8000`):

```bash
tail -n 3 /tmp/uvicorn.log
```{{exec}}

The **gateway** is the front door to every model server behind it — the place auth, timeouts, and rate
limits live in production. Right now the "model server" is a single Python function; in Step 4 you'll put
a real batch queue in front of it.

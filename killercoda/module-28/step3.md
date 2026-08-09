# Step 3 — Hit it with curl

Ask if the service is alive:

```bash
curl -s http://localhost:8000/healthz
```{{exec}}

You should see `{"status":"ok"}`. Now send a **known input** and check the answer — for `x = 10` the
model must return `y = 21` (`2·10 + 1`):

```bash
curl -s -X POST http://localhost:8000/predict \
  -H 'content-type: application/json' -d '{"x": 10}'
```{{exec}}

Try another to convince yourself it's deterministic (`x = 4` → `y = 9`):

```bash
curl -s -X POST http://localhost:8000/predict \
  -H 'content-type: application/json' -d '{"x": 4}'
```{{exec}}

If `/healthz` says `ok` and `/predict` returns `{"y":21.0}` for `x = 10`, your gateway serves. (If curl
can't connect, the server may still be starting — check `tail /tmp/uvicorn.log` and retry.)

That JSON-over-HTTP request/response is the same wire shape a real LLM server answers; the difference is
what's behind the endpoint, not the endpoint itself.

Click **Check** to verify the server answers `/healthz` (200) and returns the correct prediction.

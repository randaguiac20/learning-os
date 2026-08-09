#!/bin/bash
# Killercoda step verifier: the gateway is up — /healthz returns 200 and /predict is correct for a known input.
base="http://localhost:8000"

# 1. /healthz must return HTTP 200.
code=$(curl -s -o /dev/null -w '%{http_code}' "$base/healthz")
if [ "$code" != "200" ]; then
  echo "GET /healthz did not return 200 (got '$code') — is the server running? Check: tail /tmp/uvicorn.log"
  exit 1
fi

# 2. /predict must return y = 21 for x = 10 (the deterministic model y = 2x + 1).
out=$(curl -s -X POST "$base/predict" -H 'content-type: application/json' -d '{"x": 10}')
echo "$out" | grep -q '"y":[[:space:]]*21' || {
  echo "POST /predict for x=10 did not return y=21 (got: $out) — check forward_one in ~/ai-serve/app.py"
  exit 1
}

echo "Verified: /healthz answers 200 and /predict returns y=21 for x=10. Your gateway serves."
exit 0

#!/bin/bash
# Killercoda step verifier: pass (exit 0) when POST creates (201 + id) and a bad body returns 422.
base="http://localhost:8000"

# Server up?
curl -s -o /dev/null "$base/items" || {
  echo "API not reachable on :8000 — start it: cd ~/api-lab && nohup uvicorn main:app --host 0.0.0.0 --port 8000 >/tmp/uvicorn.log 2>&1 & (see Step 3)"; exit 1; }

# 1) POST a valid item -> expect HTTP 201 and an "id" in the body.
body=$(mktemp)
code=$(curl -s -o "$body" -w "%{http_code}" -X POST "$base/items" \
  -H 'Content-Type: application/json' -d '{"name":"Verify","price":3.50}')
if [ "$code" != "201" ]; then
  echo "POST /items returned $code, expected 201 Created — set status_code=201 on the create route (Step 2)."; rm -f "$body"; exit 1
fi
if ! grep -q '"id"' "$body"; then
  echo "POST /items (201) returned no id — the response must include the server-assigned id (response_model=ItemOut)."; rm -f "$body"; exit 1
fi
rm -f "$body"

# 2) POST an invalid body (empty name, negative price) -> expect HTTP 422, NOT 500.
code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$base/items" \
  -H 'Content-Type: application/json' -d '{"name":"","price":-5}')
if [ "$code" != "422" ]; then
  echo "Invalid body returned $code, expected 422 — Pydantic Field(min_length=1)/gt=0 should reject it (Step 2/3)."; exit 1
fi

echo "Verified: POST creates with 201 + id, and invalid input is rejected with 422. Validation boundary working."
exit 0

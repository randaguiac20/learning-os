#!/bin/bash
# Killercoda step verifier: pass (exit 0) when a missing GET is 404, the protected DELETE is 401
# without a token, and 200 with the correct token.
base="http://localhost:8000"
token="Bearer secret-token"

# Server up?
curl -s -o /dev/null "$base/items" || {
  echo "API not reachable on :8000 — start it as in Step 3 (uvicorn main:app on port 8000)."; exit 1; }

# 1) GET a missing item -> expect 404 (not 200-with-error).
code=$(curl -s -o /dev/null -w "%{http_code}" "$base/items/999999")
if [ "$code" != "404" ]; then
  echo "GET /items/999999 returned $code, expected 404 — raise HTTPException(404) for a missing item (Step 2)."; exit 1
fi

# 2) DELETE with NO token -> expect 401.
code=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$base/items/1")
if [ "$code" != "401" ]; then
  echo "DELETE without a token returned $code, expected 401 — the require_token dependency must reject it (Step 2)."; exit 1
fi

# 3) Create a fresh item, then DELETE it WITH the token -> expect 200.
curl -s -o /dev/null -X POST "$base/items" \
  -H 'Content-Type: application/json' -d '{"name":"ToDelete","price":2}'
id=$(curl -s "$base/items" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d[-1]['id'] if d else '')" 2>/dev/null)
if [ -z "$id" ]; then
  echo "Could not create an item to delete — check POST /items works (Step 3)."; exit 1
fi
code=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$base/items/$id" -H "Authorization: $token")
if [ "$code" != "200" ]; then
  echo "DELETE /items/$id WITH the token returned $code, expected 200 — a valid token must be accepted (Step 4)."; exit 1
fi

echo "Verified: 404 on missing, 401 without a token, 200 with the token. Correct codes + authn enforced."
exit 0

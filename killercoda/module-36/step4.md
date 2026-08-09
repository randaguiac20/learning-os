# Step 4 — Missing (404) and the protected route (401 → 200)

A resource that isn't there is a **`404 Not Found`** — never a `200` with an error body:

```bash
curl -i -s http://localhost:8000/items/999999
```{{exec}}

The `DELETE` route is **protected** by a token. Try it with **no token** — expect **`401 Unauthorized`**:

```bash
curl -i -s -X DELETE http://localhost:8000/items/1
```{{exec}}

Now with the **correct token** — expect **`200`**, and it removes the item (recreate one first in case
you deleted it earlier):

```bash
curl -s -X POST http://localhost:8000/items \
  -H 'Content-Type: application/json' -d '{"name":"Temp","price":1}' >/dev/null
NEWID=$(curl -s http://localhost:8000/items | python3 -c "import sys,json;print(json.load(sys.stdin)[-1]['id'])")
curl -i -s -X DELETE "http://localhost:8000/items/$NEWID" \
  -H 'Authorization: Bearer secret-token'
```{{exec}}

Feel it: the *same* `DELETE` request differs only by one header, and that header is the entire difference
between **401** and **200**. This is **authentication** — verifying *who you are* — enforced by a FastAPI
dependency that runs *before* the handler.

Click **Check** to verify 404 on missing, 401 without a token, and 200 with the token.

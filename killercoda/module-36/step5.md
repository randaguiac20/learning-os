# Step 5 — The API documents itself (OpenAPI)

You never wrote docs — yet FastAPI built the **OpenAPI** contract (the machine-readable API spec, also
called Swagger) straight from your type hints. See it:

```bash
curl -s http://localhost:8000/openapi.json | head -c 400 ; echo
```{{exec}}

That JSON lists every path, method, request schema, and response — the contract other teams build
against. Pull just the paths to see your resource laid out:

```bash
curl -s http://localhost:8000/openapi.json | python3 -c "import sys,json; d=json.load(sys.stdin); print('\n'.join(sorted(d['paths'])))"
```{{exec}}

In a real browser, **`http://localhost:8000/docs`** is the interactive **Swagger UI** — every endpoint
with a live "Try it out" button. That auto-doc is a first-class deliverable, not an afterthought.

Stop the server now that you're done:

```bash
pkill -f "uvicorn main:app" ; echo "stopped"
```{{exec}}

You designed a resource, built it with correct methods and status codes, validated input with Pydantic,
protected a route with a token, and read the auto OpenAPI docs. That's Module 36, hands-on.

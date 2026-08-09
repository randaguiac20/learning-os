# Step 1 — Install the bench

Three tools, one install: **FastAPI** (the framework), **uvicorn** (the **ASGI** server —
Asynchronous Server Gateway Interface, the standard that actually runs an async Python web app), and
**httpx** (an HTTP client for scripts).

First the Python package installer:

```bash
apt-get update && apt-get install -y python3-pip
```{{exec}}

Then the three libraries:

```bash
pip install fastapi uvicorn httpx
```{{exec}}

Confirm FastAPI imports cleanly:

```bash
python3 -c "import fastapi, uvicorn, httpx; print('bench ready:', fastapi.__version__)"
```{{exec}}

You now have everything to build and run a real API. **FastAPI** turns Python type hints into a validated
request/response contract *and* auto-generates the OpenAPI docs — no extra work for either.

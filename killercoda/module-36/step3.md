# Step 3 — Run it, then create (201) and validate (422)

Start the API with **uvicorn** in the background and give it a moment:

```bash
cd ~/api-lab && nohup uvicorn main:app --host 0.0.0.0 --port 8000 >/tmp/uvicorn.log 2>&1 & sleep 3
```{{exec}}

Confirm it's up:

```bash
curl -s http://localhost:8000/items ; echo
```{{exec}}

You should see `[]` — an empty list. **Create an item** — expect **`201 Created`** and a server-assigned
`id` (the `-i` flag shows the status line):

```bash
curl -i -s -X POST http://localhost:8000/items \
  -H 'Content-Type: application/json' \
  -d '{"name":"Widget","price":9.99}'
```{{exec}}

Now send a **bad body** — an empty name and a negative price. Expect **`422 Unprocessable Entity`**, and
notice the precise error FastAPI returns *without you writing one line of validation*:

```bash
curl -i -s -X POST http://localhost:8000/items \
  -H 'Content-Type: application/json' \
  -d '{"name":"","price":-5}'
```{{exec}}

A `422` (not a `500`) tells every client and monitor: *you sent bad input*. That is Pydantic acting as a
**security boundary** — garbage is rejected at the door, not crashed on inside. (If `curl` can't connect,
check `/tmp/uvicorn.log`.)

Click **Check** to verify that create returns 201 + an id, and an invalid body returns 422.

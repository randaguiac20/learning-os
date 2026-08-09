# Step 3 — Sockets: start a listener

A **port** is a program's mailbox number; a **socket** is the full tuple `(protocol, local addr:port,
remote addr:port)`. Start a real HTTP server in the background — it will own port 8080:

```bash
nohup python3 -m http.server 8080 >/tmp/http.log 2>&1 &
```{{exec}}

Give it a moment, then read the socket directory — every LISTEN socket on the machine:

```bash
sleep 1
sudo ss -tlnp
```{{exec}}

Find the `:8080` line. The flags mean: `-t` tcp · `-l` listening · `-n` numeric (don't resolve) · `-p`
process. Now narrow to just that socket and read its **bind address**:

```bash
sudo ss -tlnp 'sport = :8080'
```{{exec}}

- A `0.0.0.0:8080` bind listens on **every** interface — reachable from outside (if the firewall allows).
- A `127.0.0.1:8080` bind is **loopback-only** by design — local connections only.

`python3 -m http.server` binds `0.0.0.0` by default, so it's reachable on any of this machine's
addresses. **Leave the server running** — steps 4 and 5 talk to it.

Click **Check** to verify your local server is up and reachable.

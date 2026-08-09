# Step 5 — A tunnel, and watch the door

SSH carries more than a shell — it can **forward a port**. A *local forward* (`-L`) opens a port on your
side and pipes it, encrypted, to an address the **server** can reach. Classic use: reach a service that
only listens on the remote's localhost.

Start a tiny "internal" service on the box, bound to localhost as if it were private:

```bash
(cd /tmp && nohup python3 -m http.server 8000 >/tmp/http.log 2>&1 &) ; sleep 1
```{{exec}}

Open a background tunnel — your local **9000** → the box's **localhost:8000**, over SSH:

```bash
ssh -fN -L 9000:localhost:8000 mybox
```{{exec}}

Now reach the "private" service through the encrypted tunnel, from your side on 9000:

```bash
curl -s localhost:9000 | head -5
```{{exec}}

That traffic never crossed the network in the clear — it rode **inside** the SSH connection. `-L` is the
cousin of `kubectl port-forward` you'll meet at M19.

**Watch the door.** Every login attempt is logged — see sshd record your key logins:

```bash
grep sshd /var/log/auth.log 2>/dev/null | tail -10 || journalctl -u ssh --no-pager 2>/dev/null | tail -10
```{{exec}}

Public servers see constant brute-force noise here — exactly why you disable password auth and rely on
keys (M24 hardens this fully). Close the tunnel when done:

```bash
pkill -f 'ssh -fN -L 9000' 2>/dev/null; echo closed
```{{exec}}

Click **Continue** to wrap up.

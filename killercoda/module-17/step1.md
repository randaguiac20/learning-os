# Step 1 — Install containerd and meet the three pieces

Install the runtime daemon, the reference OCI runtime, and `jq` (one command):

```bash
sudo apt-get update -qq && sudo apt-get install -y containerd runc jq
```{{exec}}

Now start containerd. This tries systemd first and falls back to running the daemon directly:

```bash
sudo systemctl enable --now containerd 2>/dev/null || (sudo nohup containerd >/tmp/containerd.log 2>&1 & sleep 3)
```{{exec}}

Confirm the daemon is up and reachable — `ctr version` prints BOTH a client and a server version, and the
server line only appears if the daemon answered:

```bash
sudo ctr version
```{{exec}}

Meet the low-level runtime — a binary, **not** a daemon:

```bash
runc --version
```{{exec}}

```bash
which containerd ctr runc
```{{exec}}

**Three pieces, three jobs:**

- **containerd** — the daemon: pulls images, manages the layer store and snapshots, supervises lifecycles.
- **`ctr`** — containerd's raw admin client (the tool you'll drive it with here).
- **`runc`** — the OCI runtime that actually creates a container and then **exits**.

Notice there is no `dockerd` on this machine. You are about to run a container without it.

# Step 2 — containerd's own namespaces

containerd is multi-tenant: it partitions its state into **containerd namespaces**. These are the
daemon's own multi-tenancy — **not** the kernel namespaces that isolate a process. Same word, two
completely different worlds.

List them (likely empty, or just `default`):

```bash
sudo ctr namespace ls
```{{exec}}

Create one of your own:

```bash
sudo ctr namespace create demo
```{{exec}}

```bash
sudo ctr namespace ls
```{{exec}}

**Why this matters in the real world:** on a machine that also runs Docker, `ctr namespace ls` shows a
namespace called `moby` — Docker's private one. That is why a bare `ctr container ls` shows *nothing* even
while Docker is running containers: they live in `moby`, and you have to ask for them explicitly:

```bash
sudo ctr -n moby container ls   # (empty here — no Docker on this VM — but this is the pattern)
```{{exec}}

The classic below-deck confusion is `ctr` "showing nothing." The fix is almost always the containerd
namespace: `-n moby` for Docker's containers. Keep this separate in your head from the **kernel**
namespaces (PID, mount, network, ...) that isolate what a process can *see* — those come next module's
deep-dives; this one is just the daemon's filing cabinet.

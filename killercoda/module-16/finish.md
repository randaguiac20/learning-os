# Done — you can build and run containers

In about half an hour you:

- **Ran a container** and proved it is a **normal process** — found it in the host's `ps`, saw it as
  **PID 1** inside its own namespace. No boot, no guest OS.
- Wrote a **Dockerfile** and `docker build`t it into an **image** — one layer per instruction, read with
  `docker history`.
- **Ran your image**, **published a port** (`-p` = a DNAT rule), and persisted data in a **named
  volume** that outlived the container — the state boundary.
- Stood up a **2-service `docker compose` rig** whose `probe` reached `web` **by name** through the
  embedded DNS at `127.0.0.11`.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back), attempt the *Solo Lab* challenges
(cache-order fix, host-only publish, the 10-second stop, a hardened multi-stage image), and tick the
*Mastery checklist*. When every box is honestly true, M17 (containerd & OCI Internals) — which dissects
exactly what you just built — becomes current.

> The one-sentence takeaway: **M16 makes the environment itself an artifact — built by CI, pinned by
> digest, run as a disposable process — the packaging arc (M13's wheel → M15's rail → the image)
> completed, and the table set for Kubernetes to orchestrate what you can now build.**

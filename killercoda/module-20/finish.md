# Done — you can operate a Deployment now

In under half an hour you:

- Scoped everything to a **namespace** and checked your permissions with `kubectl auth can-i`.
- Externalised config as **data** — a **ConfigMap** and a **Secret**, injected as env vars *and* mounted
  files — and proved a Secret is only **base64, not encrypted**.
- Ran a Deployment with **readiness + liveness probes** and **requests/limits**, then watched a
  **failing liveness probe restart** a pod (`RESTARTS` climbing).
- Shipped a **bad rolling update** (an impossible memory request → `Pending`) while the old pods kept
  serving, then recovered with a **one-command `kubectl rollout undo`**.
- Walked the **day-2 troubleshooting ladder** (`get` → `describe`/Events → `logs` → `endpoints` →
  `rollout status`) and tore the lab down with one `kubectl delete namespace`.

**Back on the lesson page:** try the *Solo Lab* (least privilege by the error-driven loop, a slow-starter
probe design, a wedged rollout, the DNS-eating NetworkPolicy), do the *Self-Check*, and tick the
*Mastery checklist*. Module 20 is the **Stage 6 finale** — passing it closes Enterprise Architecture.

> The one-sentence takeaway: **M19 taught what the cluster is; M20 taught how to operate one — config as
> data, health that heals, bounds that protect, rollouts you can undo — every answer an object you can
> apply, inspect, and roll back.**

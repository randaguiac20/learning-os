# Step 5 — The day-2 troubleshooting ladder

When something's wrong, work the ladder **in order** — evidence before action, and fix the *template*,
never the live pod. Walk it now against your healthy `web` Deployment so the moves are reflexes before
you need them under pressure.

**1. What state is everything in?** (`Pending` / `CrashLoopBackOff` / `OOMKilled` / `ImagePullBackOff`)

```bash
kubectl get pods -o wide
```{{exec}}

**2. The Events name the real cause** — always read the bottom of `describe`:

```bash
kubectl describe deploy web | tail -20
```{{exec}}

**3. The app's own words** (`--previous` reads a crashed container's last logs):

```bash
kubectl logs deploy/web --tail=10
```{{exec}}

**4. Is a Ready pod actually wired to a Service?** Empty endpoints usually means a **readiness** failure:

```bash
kubectl get endpoints
```{{exec}}

**5. Is a rollout stuck?** If a bad version, the fix is `kubectl rollout undo` — not surgery on a pod:

```bash
kubectl rollout status deploy/web
```{{exec}}

Each rung maps a symptom to a layer: `Pending` → scheduling/requests · `CrashLoop` → app or probe ·
no endpoints → readiness · 404 → Host/Ingress · timeout (not refused) → a NetworkPolicy dropped it.

Finally, tear the whole lab down in **one command** — the payoff of scoping everything to a namespace:

```bash
kubectl delete namespace k8s-ops
```{{exec}}

That's Module 20, hands-on: config as data, health probes, resource bounds, a rollout you can undo, and
a troubleshooting method.

# T1 — single-node homelab slice (laptop, $0)

The smallest honest homelab: a **real Kubernetes cluster on your laptop** (k3d = k3s in Docker),
with an app and a Grafana dashboard deployed by **OpenTofu**. Same tools, same code shape you'll
scale to a 3-node cluster (T2) and the cloud (T3) — nothing here is throwaway.

**Cost: $0.** Needs only Docker + `k3d` + `kubectl` + `tofu` (all free). No GPU, no paid hardware.

## Install the tools

```bash
# Docker — https://docs.docker.com/engine/install/ (then add yourself to the docker group)

# OpenTofu (via Homebrew; or see https://opentofu.org/docs/intro/install/)
brew install opentofu

# k3d — k3s in Docker
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -m 0755 kubectl ~/.local/bin/kubectl && rm kubectl
```

Verify everything resolves correctly:

```bash
docker version && k3d version && kubectl version --client && tofu version
```

> **Gotcha (Debian/Ubuntu):** do **not** `apt install tofu` — `/usr/bin/tofu` on Debian belongs to
> `python3-ufo-tofu`, an unrelated image-processing toolkit. If `tofu` crashes with a Python
> traceback (`Namespace Ufo not available`), the wrong binary is being picked up: install OpenTofu
> as above and check `which -a tofu` shows the Homebrew (or `/usr/local/bin`) one first on `PATH`.

## Run it

```bash
cd homelab/tofu/t1-single-node
./bootstrap.sh          # creates the k3d cluster (context: k3d-homelab) — must end with "Ready."
tofu init               # or: terraform init
tofu apply              # deploys the demo app + Grafana
tofu output             # prints how to reach the app and Grafana
```

> **Order matters:** `bootstrap.sh` checks all four tools and **aborts with install hints** if any
> is missing — nothing is created in that case, so fix what it reports and re-run it until it ends
> with `Ready.` Don't skip past a failure: `tofu init` succeeds even *without* a cluster (it only
> downloads providers), so a green `init` proves nothing. If `tofu apply` fails with
> `context "k3d-homelab" does not exist`, bootstrap never finished — go back to step 1.

Reach the app and dashboard — **stable URLs, no port-forward needed** (k3d maps
`localhost:8080` to the cluster's Traefik ingress; browsers resolve `*.localhost` to `127.0.0.1`):

- **App:** <http://whoami.localhost:8080>
- **Grafana:** <http://grafana.localhost:8080> — user `admin`, password `homelab-admin`
  (fixed by the `grafana_admin_password` variable so it survives rebuilds; override it for
  anything beyond a local lab)

These URLs are declared as Ingress resources in the tofu code, so they **keep working after
every `destroy`/`apply`** — nothing to restart, nothing to re-run.

<details>
<summary>Fallback: port-forward (only if ingress is unavailable)</summary>

```bash
kubectl -n demo port-forward svc/whoami 8088:80             # http://localhost:8088
kubectl -n observability port-forward svc/grafana 3000:80   # http://localhost:3000
```

A port-forward is a tunnel to **one specific pod** — it dies the moment that pod is recreated
(any `destroy`/`apply`, restart, or upgrade) and never reconnects on its own. Re-run it after
every rebuild. This is exactly why the ingress URLs above are the primary path.
</details>

Tear down (proves reproducibility — re-`apply` rebuilds it identically, same URLs, same login):

```bash
tofu destroy            # ALWAYS destroy before deleting the cluster (see below)
k3d cluster delete homelab
```

## Troubleshooting

| Symptom | Cause & fix |
|---|---|
| `context "k3d-homelab" does not exist` on `apply` | Bootstrap never finished — re-run `./bootstrap.sh` until it ends with `Ready.` |
| `apply`/`destroy` hangs or errors about unreachable cluster, but `k3d cluster list` shows none | You deleted the cluster **before** `tofu destroy`, so the state file references resources that no longer exist. Reset with `rm -f terraform.tfstate terraform.tfstate.backup`, then `./bootstrap.sh && tofu apply`. |
| URLs dead after a rebuild | Should not happen with the ingress URLs. If you were using port-forwards: they die with the pod — re-run them, or just use the ingress URLs. |
| `whoami.localhost` doesn't resolve | Every mainstream browser and systemd-based Linux resolves `*.localhost` to `127.0.0.1`. If your tool doesn't: `curl -H "Host: whoami.localhost" http://localhost:8080` or add it to `/etc/hosts`. |

## What this teaches / proves

- Kubernetes objects as **declarative IaC** (namespace, Deployment, Service) — the production pattern.
- **Helm** releases managed from the same codebase (Grafana).
- The **reproducibility loop**: destroy + apply = same result from Git. That loop is the whole point
  of the homelab, and the thing a hiring manager wants to see.

## Where it goes next

| Step | Tier | Adds |
|---|---|---|
| Publish the app to the internet | T1→ | **Cloudflare Tunnel** (no open ports) → your first live public demo |
| 3-node HA cluster | **T2** | k3s HA or Talos · **Argo CD/Flux** GitOps · full Prometheus/Alertmanager/Loki |
| Cloud, one codebase | **T3** | same modules target EKS/AKS/GKE free tiers · Tailscale mesh |
| GPU serving | capstone | NVIDIA device plugin + vLLM/KServe (or CPU/cloud-spot fallback) |

See `../../README.md` for the full three-tier architecture and the showcase checklist.

> **Currency note:** use **OpenTofu** (`tofu`) — Terraform moved to the BSL licence. The commands are
> otherwise identical (`terraform init/apply` also work).

# Homelab RUNBOOK — exact commands per tier

Each step is tagged **[automatable]** (runs from code, $0, local) or **[manual/needs-account]**
(needs a cloud/SaaS account or physical hardware). Nothing here bills by surprise: cloud steps carry
budget-alert + stop/delete guardrails.

## Prerequisites (install into user space; all free)

| Tool | Install | Tier |
|---|---|---|
| Docker | https://docs.docker.com/engine/install/ | T1+ |
| k3d | https://k3d.io | T1 |
| kubectl | https://kubernetes.io/docs/tasks/tools/ | all |
| OpenTofu (`tofu`) | https://opentofu.org/docs/intro/install/ | all |
| Helm | https://helm.sh/docs/intro/install/ | all |
| k3sup / Ansible | https://github.com/alexellis/k3sup · https://docs.ansible.com | T2 |
| Tailscale | https://tailscale.com/download | T1+ |
| cloudflared | https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/ | T1+ (demo) |

## T1 — laptop / single box — **[automatable, $0]**

```bash
cd homelab/tofu/t1-single-node
./bootstrap.sh            # k3d single-node cluster (context k3d-homelab)
tofu init && tofu apply   # app + Grafana
tofu output               # reach-it hints
# teardown / reproducibility proof:
tofu destroy && k3d cluster delete homelab
```

### Publish the T1 demo to the internet — **[manual/needs-account, free]**

```bash
# Cloudflare Tunnel — no open ports, no public IP, free tier.
cloudflared tunnel login
cloudflared tunnel create homelab
cloudflared tunnel route dns homelab demo.<your-domain>
# point the tunnel at the app's port-forward or a k8s Service; run:
cloudflared tunnel run homelab
```

## T2 — 3-node cluster — **[automatable if virtualized, $0; or used mini-PCs]**

- **$0 path:** create 3 VMs on T1 (or Proxmox) and install **k3s HA**; or use `k3d` multi-server.
- **Hardware path:** 3 used mini-PCs (TinyMiniMicro), ~$600–1,500.
- GitOps: bootstrap **Argo CD** (or Flux), point it at `homelab/gitops/`; mirror `bjw-s-labs/home-ops`.
- Observability: `kube-prometheus-stack` (Prometheus + Alertmanager + Grafana) + Loki, all as code.
- Secrets: SOPS + age, or sealed-secrets. Config: **Ansible** for node prep.

*(Scaffolding `tofu/t2-cluster/`, `ansible/`, `gitops/` is added when you reach the containers/K8s
stages — same provider code as T1, more nodes.)*

## T3 — cloud (hybrid) — **[manual/needs-account, free-tier + guarded]**

- Same OpenTofu modules target **EKS/AKS/GKE** free tiers / trials.
- **Guardrails, mandatory:** set a **budget alert**, use **spot** for any GPU, and **stop/delete**
  when idle. Never leave a GPU node running.
- **Tailscale** stitches local + cloud into one network; **Cloudflare Tunnel** serves the public demo.

## GPU / model serving — **[automatable if you have an NVIDIA GPU; else fallback]**

- **Have a CUDA NVIDIA GPU:** install the **NVIDIA k8s device plugin**, serve with **vLLM/KServe**.
- **No NVIDIA GPU:** CPU-only via **Ollama/llama.cpp** (any machine), Apple-Silicon **MPS**, or a
  **cloud spot GPU** for the heavy fine-tune/serve step only (guardrails above).

## Validate IaC without applying — **[automatable]**

```bash
cd homelab/tofu/t1-single-node
tofu fmt -check
tofu validate            # requires providers downloaded via `tofu init`
```

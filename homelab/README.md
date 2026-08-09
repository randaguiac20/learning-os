# Learning OS — Homelab & Public Showcase (`homelab/`)

**Pillar 2 of the platform.** The curriculum teaches concepts; this is where you *build the
infrastructure* to prove them — a documented, reproducible homelab that doubles as a **public
portfolio** for a high-pay job (SRE / platform / AI-infra) or a business seed.

One idea holds it together: **one portable IaC/GitOps codebase deploys the same stack to every
tier**, so nothing is throwaway and everything is reproducible from Git.

> This folder is authored here during development and is intended to be published as its **own public
> GitHub repo** — the portfolio centrepiece — cross-linked from the course site.

## Three-tier reference architecture (all tiers, all affordable)

| Tier | Substrate | Cost | Stack |
|---|---|---|---|
| **T1 — Laptop / single box** | a machine you own, or one used mini-PC | **$0 owned** / ~$300–900 used | Docker → **k3d/k3s** single-node → app + **Grafana** → Tailscale. *(→ `tofu/t1-single-node/`)* |
| **T2 — 3-node cluster** | 3× used mini-PCs, **or 3 VMs on T1 = $0** | ~$600–1,500, or **$0 virtualized** | **k3s HA** or **Talos** → **Argo CD/Flux** GitOps → **OpenTofu + Ansible** → Prometheus/Alertmanager/Loki → SOPS/sealed-secrets |
| **T3 — Cloud (hybrid)** | AWS/Azure/GCP **free tiers**; spot GPUs only when needed | **free-tier** + guarded spot | same IaC targets managed k8s (EKS/AKS/GKE) → **Tailscale** mesh → **Cloudflare Tunnel** publishes the live demo |

**A GPU is never a hard prerequisite.** With a CUDA-capable NVIDIA GPU, serve models locally via the
NVIDIA k8s device plugin + vLLM/Triton/KServe/Ray Serve. Without one: CPU-only quantized inference
(Ollama/llama.cpp), Apple-Silicon MPS, or a **cloud spot GPU** for the heavy step only — under budget
guardrails.

## Affordability rules (hard constraint)

Every tier has a **$0 entry** (own laptop / virtualized cluster / cloud free tier). Every cloud step
mandates **budget alerts + stop/delete + spot**. Hardware guidance is **used/cheap** (the ServeTheHome
"TinyMiniMicro" class), never new servers.

## Tooling — and honestly, what companies actually run

- **Production-standard (identical to industry):** Kubernetes, Docker/containerd, **OpenTofu/Terraform**,
  **Ansible**, **Argo CD/Flux**, **Prometheus/Grafana/Loki**, **SOPS/sealed-secrets**, **Tailscale**,
  **Cloudflare Tunnel**, **Renovate**, and the serving layer **vLLM/Triton/KServe/Ray Serve**. The
  control-plane tooling is the same on a mini-PC as in a data centre.
- **Homelab-scale substrate (production-identical skills, affordable scale):** Proxmox, TrueNAS,
  k3s/Talos, a consumer GPU. k3s is CNCF-conformant — manifests transfer to EKS unchanged.

Currency corrections (2026): **OpenTofu** (Terraform is now BSL) · **TrueNAS Linux edition** (CORE is
legacy) · GitOps reference **bjw-s-labs/home-ops** (k8s-at-home archived) · **Talos** at talos.dev/latest.

## Showcase deliverables (serves BOTH a job AND a business)

1. **Public IaC monorepo** — OpenTofu + Ansible + k8s manifests, GitOps, Renovate-managed.
2. **Architecture case study** — tiered diagram + trade-offs (k3s vs Talos, Argo vs Flux) + a day-2 runbook.
3. **Live public demo** — the capstone AI service via Cloudflare Tunnel, URL in the README.
4. **Observability + security proof** — dashboards-as-code, alert rules, Zero-Trust (Tailscale), secrets, a hardening writeup (maps to CKS).
5. **Blog + video walkthrough** — the platform's own videos double as this.
6. **Certifications** — CKA + AI-901 baseline; CKS + a cloud associate for senior roles.
7. **Business-seed artifact** — the capstone packaged as a documented, deployable inference service + a pricing/architecture one-pager.

## Build sequencing (parallel to the course)

- **Seed (now, with the pilot):** the T1 slice in `tofu/t1-single-node/` — app + Grafana on local
  k3d, reproducible from Git. Publish it via Cloudflare Tunnel as a first live demo.
- **Grow (each stage):** every module's `08-projects.md` "Production seed" adds one real component
  (containers → single-node k8s → HA cluster → observability → security → GPU serving) to this repo —
  portfolio by accretion.
- **Capstone:** the Full-Stack AI Service running across tiers, public demo live, case study + business one-pager published.

## Layout

```
homelab/
├── README.md            # this file — architecture + showcase
├── RUNBOOK.md           # exact commands per tier (automatable vs manual/needs-account)
└── tofu/
    └── t1-single-node/  # the T1 seed: k3d + app + Grafana via OpenTofu  ✅ authored
```

T2 (`tofu/t2-cluster/` + `ansible/` + `gitops/`) and T3 (`tofu/t3-cloud/`) are added as those stages
are reached — same codebase, more targets. See `RUNBOOK.md`.

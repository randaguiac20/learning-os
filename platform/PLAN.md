# Plan — Publish the Learning OS curriculum as a public, video-first teaching platform

> Portable copy of the approved plan (self-contained; no dependency on `~/.claude/plans`).
> Approved 2026-08-09. Pilot executed the same day — see `PROGRESS.md`.

## Context

`../curriculum/` is complete: **13 stages, 39 modules + a woven capstone, 450 Markdown files** (each
module has an identical 11-file layout), a pandoc→WeasyPrint PDF pipeline, and a four-accent design
system. The goal: turn this personal study system into a **platform to teach others** — per topic a
**video** + **standalone notes** (no rewatch) + a **basic guided lab** + a **harder solo lab** +
**self-check**, structured for evidence-based learning, runnable by anyone, public. Not just
knowledge — **skill**.

**Key finding:** the 11-file module design already *is* the content model. This is a **publishing +
video + labs layer over existing content**, not a rebuild. `curriculum/` stays the untouched source
of truth; all new work is **add-only** in sibling directories.

**Locked decisions:** ① first deliverable = one module fully runnable · ② labs runnable from the
start · ③ hybrid video (asciinema casts + selective OBS explainers) · ④ fully public & free (GitHub
Pages + YouTube) · ⑤ a **homelab pillar** → public showcase for a high-pay job or a business · ⑥
homelab spans **ALL tiers** (laptop, 3-node, cloud) as one portable architecture · ⑦ **every lab and
homelab option affordable** ($0/free-tier entry + guardrails).

**Two pillars: (1) the teaching platform, (2) a homelab + public showcase.**

## Recommended stack (all official, verified live Aug 2026)

| Layer | Choice | Why |
|---|---|---|
| Site | **Material for MkDocs** → GitHub Pages | Markdown-native → 450 `.md` drop in with near-zero rework; admonitions, tabs, collapsibles, search, mermaid |
| Diagrams | **mermaid.js** via `pymdownx.superfences` | Web renders real diagrams (PDF degraded them to ASCII) |
| Screen video | **OBS Studio** | Free standard for narrated explainers |
| Terminal casts | **asciinema** + player | Tiny, text, copy-pasteable, embeddable |
| Edit | **Kdenlive** | Simple cuts + captions on Linux |
| Host video | **YouTube** (embedded) | Max free reach |
| Labs — Linux/Docker/K8s | **Killercoda** | Browser terminals w/ preinstalled clusters (NOT Play with Docker/K8s — discontinued 2026-03-01) |
| Labs — coding/AI | **GitHub Codespaces + `.devcontainer`** | Zero-setup cloud dev env, free personal tier |
| Gear | **Samson Q2U** mic + **Logitech C920s** + one light | Audio-first; dynamic mic rejects room noise |

## Per-topic lesson template (8 sections → the 11 curriculum files)

Evidence-based loop: **one input → retrieve → apply easy → apply hard → self-test → schedule review.**

1. **Why this matters** ← `01-module-blueprint` (Definition/Purpose) + `09-knowledge-connections`
2. **Watch** — one OBS explainer + inline asciinema casts; script from `01-module-blueprint` (Analogy/Visual Model/Misconceptions)
3. **Key Notes** (standalone) ← `01-module-blueprint` core + `05-active-recall`; ends with 3–5 must-remember points
4. **Guided Lab** (basic) ← `03-hands-on-labs` Lab N + `07-deliberate-practice` L1–L2; "Open interactive lab" button
5. **Solo Lab** (harder) ← `03-hands-on-labs` challenges + `07-deliberate-practice` L4–L5 + `08-projects`; collapsible hint/solution
6. **Self-Check** ← `04-knowledge-validation` + `05-active-recall` + `10-teach-back` (flashcards + teach-back)
7. **Mastery checklist** ← `11-mastery-checklist` (gates progress)
8. **Review footer** ← `06-review-plan` + `09-knowledge-connections` (day-1/7/30 + interleave links)

Reference implementation: `site/docs/stage-01/module-01.md`.

## Repository layout (add-only under `/home/randagui/data/learning/`)

```
curriculum/   FROZEN source of truth (450 .md + PDF pipeline)
platform/     this meta-layer (README · PLAN · PROGRESS · RUNBOOK)
site/         MkDocs project (mkdocs.yml, docs/, docs/assets/extra.css)
labs/         killercoda/module-YY/  (+ devcontainers/ later)
media/        casts/ + README (recording) + youtube-manifest.md
homelab/      3-tier IaC + showcase (own public repo later)
.venv/        project venv — all pip installs land here
```

Lesson pages can later transclude from `curriculum/` via `pymdownx.snippets --8<--` so it stays the
single source; a small assembler script can generate pages from the 11 files.

## Phase 0 — Pilot (DONE): Module 01, fully runnable

Module 01 is the front door AND its labs run in a plain Linux terminal → Killercoda, proving template
+ lab machinery at once. Scaffold site → author lesson → record (manual) → Killercoda scenario →
`mkdocs serve`/`gh-deploy` → landing + method pages. **Executed 2026-08-09** (recording/deploy/publish
are the documented manual follow-ups).

## Phases 1–5 — scale-out

- **P1 Backbone:** full nav (13 stages/39 modules) + stage landing pages; publish Key Notes/theory for every module.
- **P2 Practice:** guided + solo labs + self-check per module, early stages first.
- **P3 Video:** hybrid asciinema+OBS progressively.
- **P4 Spaced review:** day-1/7/30 footers, cross-links, mastery gates site-wide.
- **P5 Polish:** progress tracking, cert alignment (M37 → AI-901/AWS), community links.

## "Learn how to learn" layer

First-class page citing: retrieval practice (retrievalpractice.org), spaced repetition + interleaving
(*Make It Stick*, Harvard UP 2014), deliberate practice (Ericsson 1993; *Peak*), Feynman/teach-back,
"Learning How to Learn" (Oakley & Sejnowski). Implemented: `site/docs/learn-how-to-learn.md`.

## Pillar 2 — Homelab architecture + public showcase

One portable IaC/GitOps codebase deploys the same stack to every tier; nothing is throwaway; the
whole thing is a reproducible public portfolio. Details, tiers, GPU fallbacks, affordability rules,
honest tool classification, and the showcase checklist live in `../homelab/README.md`; per-tier
commands in `../homelab/RUNBOOK.md`. T1 seed authored: `../homelab/tofu/t1-single-node/`.

Three tiers (all with a $0 entry): **T1** laptop/single-box · **T2** 3-node cluster (or $0 virtualized)
· **T3** cloud free tiers. **A GPU is never a hard prerequisite** (NVIDIA device plugin if present;
else CPU/Ollama, Apple MPS, or guarded cloud spot). Currency: OpenTofu (not Terraform-BSL), TrueNAS
Linux, bjw-s-labs/home-ops, Talos, AI-901.

## Verification (on the pilot)

1. `mkdocs build --strict` / `serve` → Module 01 renders (mermaid, tabs, collapsibles, cast wrapper, search). ✅
2. Killercoda scenario JSON valid; verify scripts pass/fail correctly. ✅
3. `gh-deploy` → public URL (manual follow-up).
4. Walk the learner loop; confirm notes are standalone (no rewatch). ✅ (structure)
5. `curriculum/` byte-for-byte unchanged. ✅
6. Homelab: `tofu apply` T1 slice + Grafana + Cloudflare Tunnel + destroy/re-apply reproducibility;
   $0/guardrail check (manual follow-up; code authored).

## Cost & effort

Everything free except gear (~mic + webcam + light) and optional Codespaces overage. Labs and homelab
all have a **$0 entry**; paid hardware is optional and used/cheap. Effort concentrates in video
recording (hybrid keeps it sustainable), lab authoring (one env per module, early first), and homelab
documentation (the showcase).

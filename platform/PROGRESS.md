# Learning OS Platform — Progress Tracker

> Single source of truth for the platform build. Mirrors the curriculum's `04-progress-tracker.md`
> convention. **Update this at the end of every working session.** Status: ☐ not started · ◐ in
> progress · ✅ done. Dates are absolute.

## Phase status

| Phase | Scope | Status |
|---|---|---|
| **Phase 0 — Pilot** | Module 01 fully runnable (vertical slice): site + lesson + labs + media + homelab seed + replication docs | ✅ 2026-08-09 |
| P1 — Backbone | Full nav (13 stages/39 modules); publish Key Notes/theory for every module | ◐ (M01 live; M02 in progress) |
| P2 — Practice | Guided + solo labs + self-check per module (early stages first) | ◐ (M01 lab published; M02 authoring) |
| P3 — Video | Hybrid asciinema + OBS per topic, progressively | ◐ (machinery proven; recordings pending) |
| P4 — Spaced review | Day-1/7/30 footers, cross-links, mastery gates site-wide | ◐ (pattern in M01) |
| P5 — Polish | Progress tracking, cert alignment, community links | ☐ |

## Phase 0 execution log (2026-08-09)

| # | Step | Status |
|---|---|---|
| 1 | Install `mkdocs-material` + `pymdown-extensions` into `../.venv` (no system installs) | ✅ |
| 2 | Scaffold `site/` — `mkdocs.yml`, `docs/assets/extra.css` (curriculum palette), `casts.js`, `requirements.txt`, `.gitignore`, `README.md` | ✅ |
| 3 | Author `site/docs/index.md` (landing + how-to-use) and `learn-how-to-learn.md` (cited methods) | ✅ |
| 4 | Author `site/docs/stage-01/module-01.md` — full 8-section pilot lesson (mermaid, tabs, collapsibles, buttons) | ✅ |
| 5 | Author Killercoda scenario `labs/killercoda/module-01/` (index.json + 5 steps + 2 verify scripts + finish) | ✅ |
| 6 | Create `media/` — recording runbook, `youtube-manifest.md`, sample `casts/module-01-demo.cast` (mirrored to site) | ✅ |
| 7 | Scaffold `homelab/` — README (3-tier + showcase), RUNBOOK, T1 OpenTofu seed (`tofu/t1-single-node/`) | ✅ |
| 8 | Create `platform/` replication docs — README, PLAN, PROGRESS, RUNBOOK | ✅ |
| 9 | Verify: `mkdocs build --strict` passes; verify scripts pass/fail correctly; `curriculum/` unchanged; save memory | ✅ |

## Session 2 log (2026-08-09, continued)

| # | Step | Status |
|---|---|---|
| 1 | Diagnosed image reports (Killercoda 404, offline mermaid/cast, TOC highlight) — all validated | ✅ |
| 2 | Fixed dark-mode **mermaid label contrast** in `extra.css` (scoped to the 4 semantic node classes) | ✅ |
| 3 | Pushed the whole platform to GitHub as a **monorepo** `randaguiac20/learning-os` (curriculum kept **local**, `.venv`/`.terraform`/`tfstate`/`site_build`/BSAIE.pdf excluded) | ✅ |
| 4 | Site **deployed** → https://randaguiac20.github.io/learning-os/ (Pages, `gh-pages`) | ✅ |
| 5 | Moved M01 scenario to top-level `killercoda/module-01/` (depth 2) so Killercoda discovers it | ✅ |
| 6 | **Published** M01 Killercoda lab; wired real URL `…/course/killercoda/module-01` into the lesson button | ✅ |
| 7 | Authored + **deployed Module 02** lesson (live); lab authored (Killercoda sync pending) | ✅ |
| 8 | Wrote `platform/ADDING-A-MODULE.md` (per-module playbook) + updated RUNBOOK/labs README with all learnings | ✅ |

## Artifact status

| Artifact | Path | State |
|---|---|---|
| Site config | `site/mkdocs.yml` | ✅ builds `--strict` |
| Palette | `site/docs/assets/extra.css` | ✅ ported from `curriculum/_assets/pdf-style.css` |
| Landing | `site/docs/index.md` | ✅ |
| Method page | `site/docs/learn-how-to-learn.md` | ✅ cited |
| **Pilot lesson (M01)** | `site/docs/stage-01/module-01.md` | ✅ 8 sections, reference implementation |
| Module 02 lesson | `site/docs/stage-01/module-02.md` | ✅ live (First Contact with the Terminal) |
| Killercoda lab M01 | `killercoda/module-01/` | ✅ **published** → `…/course/killercoda/module-01` |
| Killercoda lab M02 | `killercoda/module-02/` | ◐ authoring (sync to publish) |
| Live site | https://randaguiac20.github.io/learning-os/ | ✅ deployed (gh-pages) |
| Sample cast | `media/casts/module-01-demo.cast` (+ `site/docs/casts/`) | ✅ valid, plays via player |
| Homelab T1 seed | `homelab/tofu/t1-single-node/` | ✅ authored (apply = user step) |

## Pending — needs a person, account, or hardware (never faked)

| Item | Owner | Blocker | Where documented |
|---|---|---|---|
| Publish M02 Killercoda lab (Sync Now) | user | free Killercoda | `platform/ADDING-A-MODULE.md` §5 |
| Record explainer videos → YouTube | user | mic + OBS + account | `media/README.md` |
| Record real asciinema casts of the labs | user | asciinema (pip) + TTY | `media/README.md` |
| `tofu apply` the T1 homelab seed | user | Docker + k3d + tofu installed | `homelab/tofu/t1-single-node/README.md` |

**Done since the pilot (2026-08-09):** ✅ monorepo pushed to GitHub (`curriculum/` local-only) · ✅ site
live · ✅ dark-mode mermaid fix · ✅ M01 Killercoda lab published + URL wired · ✅ Module 02 authored.

---

## Current position / Next up

- **Full build-out in progress (2026-08-09):** authoring all remaining modules M03–M39 in
  dependency-order, one stage per batch, via parallel builders → wire nav + manifest → `build
  --strict` → local commit. **Not pushed/deployed yet** (waiting on user go).
  - ✅ **Batch 1 — Stage 2 Core Concepts (M03 Linux Essentials, M04 Linux Admin, M05 Bash):**
    lessons + Killercoda labs authored, `build --strict` EXIT=0, committed locally.
  - ✅ **Batch 2 — Stage 3 Intermediate Skills (M06 Vim, M07 Tmux, M08 Git, M09 SSH,
    M10 Dotfiles/Toolchains, M11 Claude Code):** lessons + Killercoda labs authored (builders were
    interrupted mid-run; orchestrator stripped leaked tags from 4 lessons and finished 10 partial
    lab files by hand), `build --strict` EXIT=0, committed locally. M11 lab is API-free (scaffolds
    CLAUDE.md/.claude config); M09 SSH uses localhost + own key; M08 Git uses a throwaway `~/git-lab`.
  - ✅ **Batch 3 — Stage 4 Advanced (M12 Programming Fundamentals, M13 Python for Engineers,
    M14 Networking):** lessons + Killercoda labs (Python venv/pytest, networking tools), verifiers
    functionally tested, `build --strict` EXIT=0, committed locally.
  - ✅ **Overall correction — lab-button rendering:** all 44 buttons across M01–M11 were rewriting the
    `.lo-btn` class INSIDE the link label (rendered as literal text, no styling); moved to post-paren
    attr_list; validated in built HTML (4 `<a class=lo-btn>`/page, 0 literal braces site-wide);
    playbook hardened. M12+ authored correct from the start.
  - ✅ **Batch 4 — Stage 5 Production Practices (M15 Automation, M16 Docker, M17 containerd & OCI,
    M18 devcontainers):** lessons + Killercoda labs (Docker/containerd on full-VM images, Ansible
    idempotence, devcontainer scaffold+build), `build --strict` EXIT=0, buttons validated, committed.
  - ✅ **Batch 5 — Stage 6 Enterprise (M19 Kubernetes Core, M20 K8s Operations) + Stage 7 Optimization
    (M21 CPU & Memory Perf, M22 GPU & NPU Perf):** lessons + labs (K8s on kubernetes-kubeadm-1node;
    perf via stress-ng/mpstat + a C cache-locality timer; M22 GPU-optional with CPU roofline/batching
    experiments), `build --strict` EXIT=0, buttons validated, committed. (Stripped a stray-tag leak
    from M20; M20 builder also fixed a request>limit bug.)
  - ✅ **Batch 6 — Stage 8 Troubleshooting (M23 Debugging) + Stage 9 Professional Workflows
    (M24 Security, M25 Observability) + Stage 10 start (M26 AI Foundations, M27 Machine Learning,
    M28 AI Infrastructure):** lessons + labs (strace/git-bisect planted bugs; ufw/sshd hardening;
    real Prometheus + PromQL; numpy embeddings; sklearn digits; FastAPI batching gateway),
    `build --strict` EXIT=0, buttons validated, committed.
  - ✅ **Batch 7 — M29 Claude Code Advanced + Stage 11 Math/CS (M30 Discrete Math & LinAlg,
    M31 Calc/Prob/Stats, M32 Data Structures & Algorithms) + Stage 12 (M33 Databases & SQL,
    M34 Big Data):** lessons + labs (API-free .claude config; numpy math; stdlib DS&A; sqlite3;
    DuckDB/Parquet), first-use terminology rule applied, `build --strict` EXIT=0, buttons validated,
    committed. (M33 sqlite3 lab logic proven via Python sqlite3 since the CLI wasn't local.)
  - ✅ **Batch 8 — final (M35 SWE Practice, M36 Backend/API [stage-12]; M37 Cloud/IaC, M38 NLP,
    M39 Computer Vision [stage-13]):** lessons + labs (TDD/pytest, FastAPI CRUD+auth tested via
    TestClient, OpenTofu plan/apply/state, TF-IDF classifier, numpy Sobel convolution), committed.
  - ✅ **ALL 39 MODULES COMPLETE.** Pre-push sweep green: 39 lesson pages, 39 nav entries, 39
    Killercoda labs (json valid + verify scripts parse); site-wide every page has 4 working
    `lo-btn` anchors + 0 literal braces; 0 stray tool-call tags; 0 forbidden diagram styling;
    `mkdocs build --strict` EXIT=0. (`$$` in M05/M17/M23 confirmed as shell PID, not MathJax.)
  - **Still LOCAL only — not pushed/deployed.** Awaiting user go for: `git push origin main` +
    `mkdocs gh-deploy --force` + Killercoda **Sync Now** for M02–M39.
  - **Pre-push sweep TODO:** (1) site-wide button-render check; (2) first-use terminology-expansion
    pass across all lessons (rule added to ADDING-A-MODULE.md).
- **Current:** Site is **live and public**; **M01** fully done (lesson + published lab);
  **M02–M05** authored (lessons + labs); **M02+** Killercoda labs pending user **Sync Now**.
- **Next up:** finish Batch 2 → wire + strict-build + commit → continue Batch 3 (Stage 4).
  Then, when the user gives the word: `git push` + `gh-deploy --force` + Killercoda **Sync Now**.
- **The one instruction to follow for every module:** `platform/ADDING-A-MODULE.md` — author lesson →
  author `killercoda/module-XX/` (depth 2) → nav + manifest → `build --strict` → commit + push →
  `gh-deploy --force` → Killercoda **Sync Now** → mark ✅ here.
- **Invariants:** `curriculum/` stays frozen + local-only; scenarios live at top-level `killercoda/`;
  deploy with `--force`; preview with internet (mermaid + casts load from a CDN).

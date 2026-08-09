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

- **Current:** Site is **live and public**; **Module 01** fully done (lesson + published lab);
  **Module 02** authored (lesson + lab), pending its Killercoda **Sync Now** to publish.
- **Next up:** (1) publish M02's lab (Killercoda → Sync Now → confirm it opens). (2) Author
  **Module 03 — Linux Essentials** (`curriculum/stage-02-core-concepts/module-03-linux-essentials/`)
  with the same 8-section template.
- **The one instruction to follow for every module:** `platform/ADDING-A-MODULE.md` — author lesson →
  author `killercoda/module-XX/` (depth 2) → nav + manifest → `build --strict` → commit + push →
  `gh-deploy --force` → Killercoda **Sync Now** → mark ✅ here.
- **Invariants:** `curriculum/` stays frozen + local-only; scenarios live at top-level `killercoda/`;
  deploy with `--force`; preview with internet (mermaid + casts load from a CDN).

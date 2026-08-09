# Learning OS Platform — Progress Tracker

> Single source of truth for the platform build. Mirrors the curriculum's `04-progress-tracker.md`
> convention. **Update this at the end of every working session.** Status: ☐ not started · ◐ in
> progress · ✅ done. Dates are absolute.

## Phase status

| Phase | Scope | Status |
|---|---|---|
| **Phase 0 — Pilot** | Module 01 fully runnable (vertical slice): site + lesson + labs + media + homelab seed + replication docs | ✅ 2026-08-09 |
| P1 — Backbone | Full nav (13 stages/39 modules); publish Key Notes/theory for every module | ☐ |
| P2 — Practice | Guided + solo labs + self-check per module (early stages first) | ☐ (M01 done) |
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

## Artifact status

| Artifact | Path | State |
|---|---|---|
| Site config | `site/mkdocs.yml` | ✅ builds `--strict` |
| Palette | `site/docs/assets/extra.css` | ✅ ported from `curriculum/_assets/pdf-style.css` |
| Landing | `site/docs/index.md` | ✅ |
| Method page | `site/docs/learn-how-to-learn.md` | ✅ cited |
| **Pilot lesson** | `site/docs/stage-01/module-01.md` | ✅ 8 sections, reference implementation |
| Killercoda lab | `labs/killercoda/module-01/` | ✅ authored + verify scripts tested |
| Sample cast | `media/casts/module-01-demo.cast` (+ `site/docs/casts/`) | ✅ valid, plays via player |
| Homelab T1 seed | `homelab/tofu/t1-single-node/` | ✅ authored (apply = user step) |

## Pending — needs a person, account, or hardware (never faked)

| Item | Owner | Blocker | Where documented |
|---|---|---|---|
| Record M01 explainer video → YouTube | user | mic + OBS + account | `media/README.md` |
| Record real asciinema cast of M01 labs | user | asciinema (pip) + TTY | `media/README.md` |
| Publish M01 Killercoda scenario | user | free Killercoda + GitHub | `labs/README.md` |
| `mkdocs gh-deploy` to public GitHub Pages | user | GitHub repo + auth | `platform/RUNBOOK.md` |
| `tofu apply` the T1 homelab seed | user | Docker + k3d + tofu installed | `homelab/tofu/t1-single-node/README.md` |
| Wire real URLs into lesson buttons + manifest | either | after publishes above | `media/youtube-manifest.md` |

After each pending item is done, replace the placeholder URL in `site/docs/stage-01/module-01.md`
and update `media/youtube-manifest.md`.

---

## Current position / Next up

- **Current:** Phase 0 (pilot) **complete and verified** — Module 01 is the runnable reference
  implementation across site + labs + media + homelab + replication docs.
- **Next up (P1 Backbone):** fill the full `nav:` in `site/mkdocs.yml` for all 13 stages / 39 modules,
  add stage landing pages, and publish **Key Notes/theory for every module** (highest value, lowest
  effort — makes the site immediately useful as a reading resource). Author lessons with the same
  8-section template, composing from each module's 11 curriculum files (a small assembler script can
  later generate pages via `pymdownx.snippets --8<--` includes).
- **Then (P2):** add guided + solo labs + self-check per module, early stages first, with a
  Killercoda scenario (or devcontainer for coding modules) per module as needed.
- **Recommended next single action:** generate `site/docs/stage-01/module-02.md` (Module 02 — First
  Contact with the Terminal) using `site/docs/stage-01/module-01.md` as the template, then extend the
  Killercoda scenario set. Keep `curriculum/` frozen.

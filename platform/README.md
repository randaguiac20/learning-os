# Learning OS — Teaching Platform (START HERE)

This folder is the **entry point and single source of truth** for turning the Learning OS curriculum
into a public, video-first teaching platform. If you are a new or resumed session, read this file
first, then `PROGRESS.md` to see exactly where things stand.

> **Live site:** https://randaguiac20.github.io/learning-os/ · **Repo:** github.com/randaguiac20/learning-os
> (monorepo on `main`; `curriculum/` is **local-only**, gitignored). Redeploy after edits:
> `cd site && ../.venv/bin/mkdocs gh-deploy --force`.

## What is being built

An **add-only publishing + video + labs layer** over the existing `../curriculum/` (450 Markdown
files + PDF pipeline). The curriculum is **frozen** — the source of truth. Everything new lives in
sibling folders. Two pillars:

1. **Teaching platform** — a Material for MkDocs site where each topic has: a video, standalone notes,
   a guided (basic) lab, a solo (harder) lab, a self-check, a mastery gate, and a spaced-review footer.
2. **Homelab + public showcase** — real infrastructure (T1 laptop → T2 3-node → T3 cloud, one portable
   IaC/GitOps codebase) that becomes a public portfolio for a high-pay job or a business.

## The folders (all under `/home/randagui/data/learning/`)

| Folder | What | Status |
|---|---|---|
| `curriculum/` | **FROZEN** source of truth — never edit; **LOCAL ONLY** (gitignored, not on GitHub) | untouched |
| `platform/` | this meta-layer: PLAN, PROGRESS, RUNBOOK, **ADDING-A-MODULE** | you are here |
| `site/` | the MkDocs course site (→ live on GitHub Pages) | M01–M02 live |
| `killercoda/` | interactive labs — **top-level, depth 2** (Killercoda requirement) | M01 published, M02 authored |
| `labs/` | roles + how-to (`README.md`); `devcontainers/` later | — |
| `media/` | recording runbook + casts + YouTube manifest | M01 sample cast |
| `homelab/` | 3-tier IaC + showcase (own public repo later) | T1 seed done |

## Resume in 60 seconds

```bash
# 1. See where things stand:
cat platform/PROGRESS.md          # tracker + "Current position / Next up"

# 2. Preview the site (uses the project venv — no system installs):
cd site && ../.venv/bin/mkdocs serve      # http://127.0.0.1:8000
#   first time: ../.venv/bin/python -m pip install -r requirements.txt

# 3. Everything else (deploy, record, publish labs, homelab apply):
cat platform/RUNBOOK.md

# 4. To add another module end-to-end (lesson + lab + nav + deploy + Killercoda):
cat platform/ADDING-A-MODULE.md
```

## The lesson template (what "done" means for a module)

8 sections, each composed from that module's 11 curriculum files:
**Why → Watch → Key Notes → Guided Lab → Solo Lab → Self-Check → Mastery → Review.**
The full section-to-file mapping is in `PLAN.md`. Module 01 is the reference implementation:
`site/docs/stage-01/module-01.md`.

## Hard rules (carried from the approved plan)

- **Add-only.** Never modify `curriculum/`. Verify it's unchanged before/after any work.
- **Affordable.** Every lab and homelab tier has a **$0 entry**; cloud steps carry budget guardrails.
- **All tiers.** The homelab covers laptop, 3-node, AND cloud as one portable codebase.
- **No system installs.** Python deps go into `../.venv` only.
- **Honest boundary.** Steps needing accounts/hardware (recording, GitHub deploy, Killercoda publish,
  cloud/GPU) are scaffolded + documented in RUNBOOK, and marked *pending* in PROGRESS — never faked.

## Files here

- **`PLAN.md`** — the full approved plan (portable; no dependency on `~/.claude/plans`).
- **`PROGRESS.md`** — live tracker + Current position / Next up. Update at the end of every session.
- **`RUNBOOK.md`** — exact commands (automatable vs manual/needs-account) for build, deploy, record, publish, apply.
- **`ADDING-A-MODULE.md`** — the repeatable per-module playbook (author lesson + lab → nav → build → deploy → Killercoda sync), with the session's gotchas.

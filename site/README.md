# Learning OS — course site (`site/`)

This is the **Material for MkDocs** project that publishes the Learning OS curriculum as a
public, video-first course. It is an **add-only publishing layer**: the source of truth stays
`../curriculum/` (450 Markdown files + PDF pipeline) — this site *composes* lesson pages from it.

## Quick start (uses the project venv — no system installs)

```bash
cd /home/randagui/data/learning/site
../.venv/bin/python -m pip install -r requirements.txt   # first time only
../.venv/bin/mkdocs serve                                # preview at http://127.0.0.1:8000
../.venv/bin/mkdocs build --strict                       # static site → ./site_build
```

Full command set (including `gh-deploy` to publish to GitHub Pages) and the manual steps
(recording, Killercoda publish) are in **`../platform/RUNBOOK.md`**.

## Layout

| Path | What |
|---|---|
| `mkdocs.yml` | Theme, plugins (superfences+mermaid, tabbed, snippets, details), nav |
| `docs/index.md` | Landing + "how to use this course" |
| `docs/learn-how-to-learn.md` | The evidence-based learning-method page (cited) |
| `docs/stage-XX/module-YY.md` | Per-topic lesson pages in the 8-section template |
| `docs/assets/extra.css` | Curriculum palette ported to the web |
| `docs/assets/casts.js` | asciinema player bootstrap |
| `docs/casts/*.cast` | Published terminal casts (mirror of `../media/casts/`) |
| `site_build/` | Generated output (git-ignored; never edit by hand) |

## Lesson page template (8 sections → the 11 curriculum files)

Header/Why · Watch · Key Notes · Guided Lab · Solo Lab · Self-Check · Mastery · Spaced-review.
See `../platform/PLAN.md` for the section-to-file mapping.

## Status

Pilot = **Module 01**, fully authored. Scale-out (all 39 modules) is Phases 1–5 in
`../platform/PROGRESS.md`.

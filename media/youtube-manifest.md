# Media manifest — video & lab URLs per module

Single registry of the external URLs each lesson embeds. Update a row when a recording is published,
then wire the URL into the matching lesson page (`site/docs/stage-XX/module-YY.md`) and lab button.

Status legend: ☐ not started · ◐ recorded, not published · ✅ live and embedded.

## Explainer videos (YouTube)

| Module | Title | YouTube ID | Status |
|---|---|---|---|
| M01 | Computer & OS Fundamentals | _(pending)_ | ☐ |

## Terminal casts (asciinema `.cast`, shipped with the site)

| Module | Cast file | Embedded on page | Status |
|---|---|---|---|
| M01 | `casts/module-01-demo.cast` → `site/docs/casts/module-01-demo.cast` | Module 01 · Watch | ✅ sample authored |

## Interactive labs (Killercoda)

| Module | Scenario source | Live URL | Status |
|---|---|---|---|
| M01 | `killercoda/module-01/` | https://killercoda.com/learning-os/course/killercoda/module-01 | ✅ published |

> Killercoda profile = `learning-os`; the top-level `killercoda/` folder became a "course", so the
> scenario URL is `…/course/killercoda/module-01`. See `labs/README.md` and `../platform/RUNBOOK.md`.

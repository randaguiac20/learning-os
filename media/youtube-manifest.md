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
| M01 | `labs/killercoda/module-01/` | `https://killercoda.com/<namespace>/scenario/module-01` _(placeholder until published)_ | ◐ authored |

> When a Killercoda scenario is published, replace `<namespace>` above **and** in the lesson page's
> "Open interactive lab" button. See `labs/README.md` and `../platform/RUNBOOK.md`.

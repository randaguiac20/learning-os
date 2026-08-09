# Media manifest — video & lab URLs per module

Single registry of the external URLs each lesson embeds. Update a row when a recording is published,
then wire the URL into the matching lesson page (`site/docs/stage-XX/module-YY.md`) and lab button.

Status legend: ☐ not started · ◐ recorded, not published · ✅ live and embedded.

## Explainer videos (YouTube)

| Module | Title | YouTube ID | Status |
|---|---|---|---|
| M01 | Computer & OS Fundamentals | _(pending)_ | ☐ |
| M02 | First Contact with the Terminal | _(pending)_ | ☐ |
| M03 | Linux Essentials | _(pending)_ | ☐ |
| M04 | Linux Administration | _(pending)_ | ☐ |
| M05 | Bash Scripting | _(pending)_ | ☐ |
| M06 | Vim | _(pending)_ | ☐ |
| M07 | Tmux | _(pending)_ | ☐ |
| M08 | Git | _(pending)_ | ☐ |
| M09 | SSH | _(pending)_ | ☐ |
| M10 | Dotfiles & Toolchains | _(pending)_ | ☐ |
| M11 | Claude Code | _(pending)_ | ☐ |

## Terminal casts (asciinema `.cast`, shipped with the site)

| Module | Cast file | Embedded on page | Status |
|---|---|---|---|
| M01 | `casts/module-01-demo.cast` → `site/docs/casts/module-01-demo.cast` | Module 01 · Watch | ✅ sample authored |
| M02 | _(pending — record per `media/README.md`)_ | Module 02 · Watch | ☐ |
| M03 | _(pending — record per `media/README.md`)_ | Module 03 · Watch | ☐ |
| M04 | _(pending — record per `media/README.md`)_ | Module 04 · Watch | ☐ |
| M05 | _(pending — record per `media/README.md`)_ | Module 05 · Watch | ☐ |
| M06 | _(pending — record per `media/README.md`)_ | Module 06 · Watch | ☐ |
| M07 | _(pending — record per `media/README.md`)_ | Module 07 · Watch | ☐ |
| M08 | _(pending — record per `media/README.md`)_ | Module 08 · Watch | ☐ |
| M09 | _(pending — record per `media/README.md`)_ | Module 09 · Watch | ☐ |
| M10 | _(pending — record per `media/README.md`)_ | Module 10 · Watch | ☐ |
| M11 | _(pending — record per `media/README.md`)_ | Module 11 · Watch | ☐ |

## Interactive labs (Killercoda)

| Module | Scenario source | Live URL | Status |
|---|---|---|---|
| M01 | `killercoda/module-01/` | https://killercoda.com/learning-os/course/killercoda/module-01 | ✅ published |
| M02 | `killercoda/module-02/` | https://killercoda.com/learning-os/course/killercoda/module-02 _(Sync Now to publish)_ | ◐ authored |
| M03 | `killercoda/module-03/` | https://killercoda.com/learning-os/course/killercoda/module-03 _(Sync Now to publish)_ | ◐ authored |
| M04 | `killercoda/module-04/` | https://killercoda.com/learning-os/course/killercoda/module-04 _(Sync Now to publish)_ | ◐ authored |
| M05 | `killercoda/module-05/` | https://killercoda.com/learning-os/course/killercoda/module-05 _(Sync Now to publish)_ | ◐ authored |
| M06 | `killercoda/module-06/` | https://killercoda.com/learning-os/course/killercoda/module-06 _(Sync Now to publish)_ | ◐ authored |
| M07 | `killercoda/module-07/` | https://killercoda.com/learning-os/course/killercoda/module-07 _(Sync Now to publish)_ | ◐ authored |
| M08 | `killercoda/module-08/` | https://killercoda.com/learning-os/course/killercoda/module-08 _(Sync Now to publish)_ | ◐ authored |
| M09 | `killercoda/module-09/` | https://killercoda.com/learning-os/course/killercoda/module-09 _(Sync Now to publish)_ | ◐ authored |
| M10 | `killercoda/module-10/` | https://killercoda.com/learning-os/course/killercoda/module-10 _(Sync Now to publish)_ | ◐ authored |
| M11 | `killercoda/module-11/` | https://killercoda.com/learning-os/course/killercoda/module-11 _(Sync Now to publish)_ | ◐ authored |

> Killercoda profile = `learning-os`; the top-level `killercoda/` folder became a "course", so the
> scenario URL is `…/course/killercoda/module-01`. See `labs/README.md` and `../platform/RUNBOOK.md`.

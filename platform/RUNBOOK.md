# Platform RUNBOOK — every command, in one place

Reproducible commands to build, preview, deploy, record, and publish the platform. Steps are tagged
**[automatable]** (runs from code, $0, local) or **[manual/needs-account]**. All Python installs go
into the project venv (`/home/randagui/data/learning/.venv`) — **never system-wide**.

> To add a whole new module end-to-end, follow **`platform/ADDING-A-MODULE.md`** (the step-by-step
> playbook). This file is the command reference it draws on.

## 0. One-time setup — **[automatable]**

```bash
cd /home/randagui/data/learning
# venv already exists (created for the curriculum PDF pipeline). Add the site deps:
.venv/bin/python -m pip install -r site/requirements.txt
```

Verify the toolchain:

```bash
.venv/bin/python -c "import material, pymdownx, mkdocs; print('mkdocs-material OK')"
```

## 1. Preview the site locally — **[automatable]**

```bash
cd /home/randagui/data/learning/site
../.venv/bin/mkdocs serve            # http://127.0.0.1:8000  (live-reload)
```

## 2. Build the static site (CI check) — **[automatable]**

```bash
cd /home/randagui/data/learning/site
../.venv/bin/mkdocs build --strict   # output → ./site_build (git-ignored)
```

`--strict` fails on broken internal links / bad config. (Material prints an unrelated advisory about a
future "MkDocs 2.0"; that is informational, not an error — a clean build ends with `EXIT=0`.)

## 3. Publish to GitHub Pages — **[manual/needs-account]**

**Already set up:** repo = `github.com/randaguiac20/learning-os` (a **monorepo** rooted at the project
folder — `site/` is a subfolder; `curriculum/` is gitignored / local-only). Live site:
**https://randaguiac20.github.io/learning-os/** (Pages serves branch `gh-pages`, root).

Recurring publish — source to `main`, then built site to `gh-pages`:
```bash
cd /home/randagui/data/learning
git add -A && git commit -m "…"
git push origin main
cd site && ../.venv/bin/mkdocs gh-deploy --force   # --force REQUIRED: local gh-pages diverged after the repo was re-rooted
# wait ~1 min for Pages to rebuild, then verify:
curl -s -o /dev/null -w "%{http_code}\n" https://randaguiac20.github.io/learning-os/   # expect 200
```

## 4. Record media

### Terminal casts (asciinema) — **[automatable]**
```bash
.venv/bin/python -m pip install asciinema
.venv/bin/asciinema rec media/casts/module-XX.cast --idle-time-limit 2 --title "Module XX"
# ...run the lab commands, Ctrl-D to stop...
cp media/casts/module-XX.cast site/docs/casts/     # publish (MkDocs serves from docs/)
```
Reference it on the page:
```html
<div class="asciinema-player-wrapper" data-cast="../casts/module-XX.cast"></div>
```

### Explainer video (OBS → Kdenlive → YouTube) — **[manual/needs-account]**
Full gear + settings + script guidance: `media/README.md`. After upload, replace the
`lo-video-placeholder` card in the lesson with the `<iframe>` embed (snippet is in the lesson's
"For the author" collapsible), and update `media/youtube-manifest.md`.

## 5. Publish interactive labs (Killercoda) — **[manual/needs-account]**

> **You publish once; every student just clicks the lesson button** — students need no Killercoda
> account or setup (see the "two roles" note in `labs/README.md`).

Scenarios live at **`killercoda/module-XX/`** (top level — Killercoda only discovers scenarios
**≤ 2 folders deep**; deeper is silently ignored). Validate, then publish:
```bash
python3 -m json.tool killercoda/module-XX/index.json   # validate (automatable)
```
1. Push to `main` (step 4 above).
2. Killercoda → **Login with GitHub** → **Creator → Repository**: Repo Name **`randaguiac20/learning-os`**
   (owner/repo, case-sensitive — NOT the `github.io` URL), Branch **`main`** → Save → **Sync Now**.
3. **My Scenarios** lists it at `https://killercoda.com/learning-os/course/killercoda/module-XX`
   (profile = `learning-os`; the top-level `killercoda/` folder is treated as a "course").
4. If the lesson button used the step-1 URL pattern it already points there — confirm it opens, then
   mark it ✅ in `media/youtube-manifest.md`.

## 6. Homelab (Pillar 2)

Full per-tier commands: `homelab/RUNBOOK.md`. The T1 seed, condensed — **[automatable, $0]**:

```bash
cd homelab/tofu/t1-single-node
./bootstrap.sh            # k3d single-node cluster
tofu init && tofu apply   # app + Grafana   (install tofu: https://opentofu.org)
tofu output               # how to reach them
tofu destroy && k3d cluster delete homelab   # reproducibility proof
```
Public live demo via Cloudflare Tunnel + cloud tiers: **[manual/needs-account]** — see `homelab/RUNBOOK.md`.

## 7. Safety check — curriculum must stay frozen — **[automatable]**

```bash
# curriculum/ is the source of truth and must never change. Confirm nothing was touched:
find /home/randagui/data/learning/curriculum -newer /home/randagui/data/learning/platform/PLAN.md -type f
# (expect: no output — no curriculum file newer than the platform work)
```

## Directory quick-map

```
learning/
├── curriculum/   FROZEN source of truth — LOCAL ONLY (gitignored, not on GitHub)
├── platform/     README · PLAN · PROGRESS · RUNBOOK (this file) · ADDING-A-MODULE (per-module playbook)
├── site/         MkDocs site  → mkdocs serve / build / gh-deploy --force
├── killercoda/   module-XX/   interactive labs — TOP-LEVEL, depth 2 (required by Killercoda)
├── labs/         README (roles + how-to) + devcontainers/ (coding labs, later)
├── media/        casts/ + README (recording) + youtube-manifest.md
├── homelab/      tofu/t1-single-node (seed) + README + RUNBOOK
└── .venv/        project venv — all pip installs land here (gitignored)
```

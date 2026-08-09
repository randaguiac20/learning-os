# Platform RUNBOOK — every command, in one place

Reproducible commands to build, preview, deploy, record, and publish the platform. Steps are tagged
**[automatable]** (runs from code, $0, local) or **[manual/needs-account]**. All Python installs go
into the project venv (`/home/randagui/data/learning/.venv`) — **never system-wide**.

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

```bash
cd /home/randagui/data/learning/site
git init && git add -A && git commit -m "Learning OS site"     # if not already a repo
git remote add origin git@github.com:<you>/learning-os.git
git push -u origin main
../.venv/bin/mkdocs gh-deploy --force   # builds + pushes to the gh-pages branch
# Then enable Pages (branch: gh-pages) in the GitHub repo settings.
# Optionally set `site_url:` in mkdocs.yml to the published URL.
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

```bash
python3 -m json.tool labs/killercoda/module-XX/index.json   # validate first (automatable)
```
Then connect the GitHub repo as a Killercoda creator source (`labs/README.md`). Scenario goes live at
`https://killercoda.com/<namespace>/scenario/module-XX`; put that URL in the lesson's "Open
interactive lab" button and in `media/youtube-manifest.md`.

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
├── curriculum/   FROZEN source of truth (do not edit)
├── platform/     README · PLAN · PROGRESS · RUNBOOK (this file)
├── site/         MkDocs site  → mkdocs serve / build / gh-deploy
├── labs/         killercoda/module-XX  (+ devcontainers later)
├── media/        casts/ + README (recording) + youtube-manifest.md
├── homelab/      tofu/t1-single-node (seed) + README + RUNBOOK
└── .venv/        project venv — all pip installs land here
```

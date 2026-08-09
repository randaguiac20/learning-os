# Labs — runnable environments (`labs/`)

Browser-based, zero-install environments so every lesson's labs actually run. Two backends:

> **Two roles — don't confuse them.** The **creator (you)** publishes each scenario to Killercoda
> **once** (the steps in this file). The **student** does **none** of that — they just click
> **▶ Open interactive lab** on the lesson page and a free browser terminal opens. No account, no
> GitHub, no setup on the student's side. You publish once; every student just clicks the link.


| Backend | For | Location |
|---|---|---|
| **Killercoda** | Linux / Docker / Kubernetes labs (a real VM in the browser) | repo-root **`killercoda/module-YY/`** (see note) |
| **GitHub Codespaces / devcontainers** | coding & AI labs (a full dev container) | `labs/devcontainers/module-YY/.devcontainer/` (added when the first coding module ships) |

> **Why Killercoda scenarios live at the repo root, not under `labs/`:** Killercoda only discovers
> scenarios **≤2 folders deep** from the repo root, so `killercoda/module-01/` is found but
> `labs/killercoda/module-01/` (3 deep) is not. Keep scenarios shallow.

## Killercoda scenarios

Each `killercoda/module-YY/` folder **is** a scenario. Structure (Katacoda-compatible):

```
module-01/
├── index.json        # scenario manifest (title, steps, backend image, verify hooks)
├── intro.md          # shown before START
├── step1.md … stepN.md
├── verify-stepN.sh   # optional: exit 0 = step passes when learner clicks "Check"
└── finish.md         # shown on completion
```

Interactive command blocks use the ` ```bash … ```{{exec}} ` fence — clicking runs it in the VM.

### Publishing (one-time, then automatic) — **[manual / needs a free account]**

1. Push this repo to GitHub (the `labs/` folder can live in the course repo or its own).
2. Sign in at **https://killercoda.com** with GitHub and add your repo as a **creator** source
   (Killercoda → Account → Creators). Scenarios are detected from folders containing `index.json`.
3. Your scenario goes live at `https://killercoda.com/randaguiac20/scenario/module-01` (namespace = your GitHub username; confirm the exact slug in Killercoda's **My Scenarios**).
4. Put that URL in the lesson page's **"Open interactive lab"** button
   (`site/docs/stage-01/module-01.md` — the `lo-btn` link) and in `media/youtube-manifest.md`'s lab table.

Until published, the lesson button points at a documented placeholder URL and every command still
runs on any Linux box or in the terminal cast. See `../platform/RUNBOOK.md`.

### Test a scenario locally before publishing

The commands are plain shell — run `intro`/step contents on any Ubuntu box (or `docker run -it ubuntu bash`)
and run the `verify-*.sh` scripts to confirm exit 0. There is no offline Killercoda renderer;
the JSON is validated in CI-style with `python3 -m json.tool index.json`.

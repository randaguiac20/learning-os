# Labs — runnable environments (`labs/`)

Browser-based, zero-install environments so every lesson's labs actually run. Two backends:

| Backend | For | Location |
|---|---|---|
| **Killercoda** | Linux / Docker / Kubernetes labs (a real VM in the browser) | `killercoda/module-YY/` |
| **GitHub Codespaces / devcontainers** | coding & AI labs (a full dev container) | `devcontainers/module-YY/.devcontainer/` (added when the first coding module ships) |

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
3. Your scenario goes live at `https://killercoda.com/<your-namespace>/scenario/module-01`.
4. Put that URL in the lesson page's **"Open interactive lab"** button
   (`site/docs/stage-01/module-01.md` — the `lo-btn` link) and in `media/youtube-manifest.md`'s lab table.

Until published, the lesson button points at a documented placeholder URL and every command still
runs on any Linux box or in the terminal cast. See `../platform/RUNBOOK.md`.

### Test a scenario locally before publishing

The commands are plain shell — run `intro`/step contents on any Ubuntu box (or `docker run -it ubuntu bash`)
and run the `verify-*.sh` scripts to confirm exit 0. There is no offline Killercoda renderer;
the JSON is validated in CI-style with `python3 -m json.tool index.json`.

# Adding a Module — the complete, repeatable playbook

Every module is published the same way. The **content already exists** in `curriculum/` (frozen,
local-only); the platform just turns it into a lesson page + a runnable lab. Follow these steps in
order. Steps are tagged **[automatable]** ($0, local) or **[manual/needs-account]**.

**Reference implementation to copy from:** Module 01 —
`site/docs/stage-01/module-01.md` (lesson) and `killercoda/module-01/` (lab).

---

## 0. Prereqs (once per machine) — [automatable]
```bash
cd /home/randagui/data/learning
.venv/bin/python -m pip install -r site/requirements.txt   # site deps into the venv
```

## 1. Author the lesson page — [automatable]
Create `site/docs/stage-XX/module-NN.md` using Module 01 as the exact template. The 8 sections map to
that module's 11 files in `curriculum/stage-XX/module-NN-.../`:

| Lesson section | Compose from |
|---|---|
| 1. Why this matters | `01-module-blueprint.md` (Definition/Purpose) + `09-knowledge-connections.md` |
| 2. Watch | `01-module-blueprint.md` (Analogy/Visual Model/Misconceptions) → video placeholder + (optional) cast |
| 3. Key Notes (standalone) | `01-module-blueprint.md` + `05-active-recall.md` + a `mermaid` diagram + a `lo-remember` callout |
| 4. Guided Lab (basic) | `03-hands-on-labs.md` Lab N + `07-deliberate-practice.md` L1–L2 + lab buttons |
| 5. Solo Lab (harder) | `03-hands-on-labs.md` challenges + `07-deliberate-practice.md` L4–L5 + `08-projects.md` (hint/solution collapsibles) |
| 6. Self-Check | `04-knowledge-validation.md` + `05-active-recall.md` + `10-teach-back.md` |
| 7. Mastery checklist | `11-mastery-checklist.md` (a `- [ ]` task-list) |
| 8. Review footer | `06-review-plan.md` + `09-knowledge-connections.md` |

Lab buttons (use the module number):
```
Open interactive lab → https://killercoda.com/learning-os/course/killercoda/module-NN
View lab source      → https://github.com/randaguiac20/learning-os/tree/main/killercoda/module-NN
```
**Mermaid:** use default theming (plain `flowchart`); do **not** add custom `classDef` fill colors —
they render unreadable in dark mode (Module 01 needed a CSS patch for that; don't repeat it).

## 2. Author the Killercoda lab — [automatable]
Create the scenario at **`killercoda/module-NN/`** — ⚠️ **top level, depth 2**. Killercoda only
discovers scenarios **≤ 2 folders deep**; anything deeper (e.g. `labs/killercoda/...`) is never found.

Files (copy `killercoda/module-01/`): `index.json`, `intro.md`, `step1.md`…`stepN.md`,
`verify-stepN.sh` (exit 0 = pass), `finish.md`. Executable command blocks use the
`` ```bash … ```{{exec}} `` fence. Validate:
```bash
python3 -m json.tool killercoda/module-NN/index.json      # JSON valid
chmod +x killercoda/module-NN/verify-*.sh
bash -n killercoda/module-NN/verify-*.sh                   # scripts parse
```

## 3. Wire it into the site — [automatable]
1. Add the page to `nav:` in `site/mkdocs.yml` under its stage.
2. Add rows to `media/youtube-manifest.md` (video ☐, cast ☐, lab URL).
3. Build:
```bash
cd site && ../.venv/bin/mkdocs build --strict     # expect: build EXIT=0
```

## 4. Ship the site — [manual/needs-account]
```bash
cd /home/randagui/data/learning
git add -A && git commit -m "Add Module NN"
git push origin main
cd site && ../.venv/bin/mkdocs gh-deploy --force  # --force: see Gotchas
# verify (wait ~1 min for Pages to rebuild):
curl -s -o /dev/null -w "%{http_code}\n" https://randaguiac20.github.io/learning-os/stage-XX/module-NN/
```

## 5. Publish the lab to Killercoda — [manual/needs-account]
In Killercoda → **Creator → Repository** (repo `randaguiac20/learning-os`, branch `main`):
click **Sync Now** → open **My Scenarios** → the new scenario appears at
`https://killercoda.com/learning-os/course/killercoda/module-NN`. Confirm the lesson's
**Open interactive lab** button opens it. (No file to edit if you used the URL pattern in step 1.)

## 6. Record media (optional, progressive) — [manual]
See `media/README.md` (asciinema cast + OBS/YouTube video). Then update the lesson's video card and
`media/youtube-manifest.md`.

## 7. Update the tracker — [automatable]
Mark the module ✅ in `platform/PROGRESS.md` and update the **Current position / Next up** block.

---

## Gotchas (learned the hard way — don't rediscover these)

| Gotcha | Rule |
|---|---|
| **Killercoda scenario depth** | Scenarios must be **≤ 2 folders** from the repo root → `killercoda/module-NN/`. Depth 3 (`labs/killercoda/...`) is silently never discovered. |
| **`gh-deploy` rejection** | The repo was re-rooted once, so the local `gh-pages` can diverge from remote → always deploy with **`mkdocs gh-deploy --force`**. |
| **Offline preview looks broken** | Mermaid diagrams + asciinema casts load their JS from a **CDN at runtime**. `mkdocs serve` **offline** shows the diagram as raw code and an empty cast. Preview **with internet**, or check the deployed site. |
| **`curriculum/` is frozen + local-only** | Never edit it; it's gitignored and **not on GitHub** (kept only on this machine). Read from it to compose lessons. |
| **Killercoda URL shape** | Profile = `learning-os`; the top-level `killercoda/` folder is treated as a **course**, so scenario URLs are `…/course/killercoda/module-NN`. |
| **No system pip installs** | All Python deps go into `/home/randagui/data/learning/.venv`. |

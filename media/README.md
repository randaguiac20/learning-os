# Media — recordings (`media/`)

The video layer. Two kinds of recording, kept deliberately lightweight so producing them stays
sustainable across 39 modules.

| Kind | Tool | When to use | Output |
|---|---|---|---|
| **Terminal cast** | **asciinema** | Any command sequence (most labs) | `.cast` file (tiny, text, copy-pasteable) |
| **Explainer video** | **OBS Studio** → edit in **Kdenlive** → **YouTube** | Concepts, diagrams, the "why" | YouTube video, embedded per lesson |

Canonical casts live in `casts/`. Published casts are mirrored into `../site/docs/casts/` (MkDocs can
only serve files under `docs/`). YouTube URLs are registered in `youtube-manifest.md`.

---

## Terminal casts with asciinema — **[automatable]**

Install into the project venv (no system install):

```bash
/home/randagui/data/learning/.venv/bin/python -m pip install asciinema
```

Record a lab, then move the cast into place:

```bash
cd /home/randagui/data/learning
.venv/bin/asciinema rec media/casts/module-01-demo.cast \
  --idle-time-limit 2 --title "Module 01 — inspect your machine"
# ... type the lab commands slowly and cleanly, then exit (Ctrl-D) to stop ...
cp media/casts/module-01-demo.cast site/docs/casts/     # publish to the site
```

Recording tips: use a clean prompt, type at a readable pace, keep it under ~3 minutes, `clear` between
sections. The lesson page renders it via the `asciinema-player-wrapper` div — no upload needed, the
`.cast` ships with the site. A hand-authored sample (`casts/module-01-demo.cast`) already proves the embed.

## Explainer videos with OBS — **[manual / needs recording]**

**Gear (audio first — audio quality matters more than video):**

- **Samson Q2U** USB dynamic mic (rejects room noise in an untreated room) — or any dynamic USB mic.
- **Logitech C920s** webcam (optional; a screen-only explainer is fine).
- One soft light in front of you; record in a soft-furnished room (curtains/carpet kill echo).

**OBS Studio** (obsproject.com) settings that work well:

- Scene: *Display/Window Capture* of the terminal + browser; optional small webcam in a corner.
- Output: 1080p, 30 fps, MP4; audio 48 kHz. Do a 20-second mic test and check levels (peak ~ −12 dB).
- Record in short takes per section; mistakes are fine — cut them in editing.

**Edit in Kdenlive** (kdenlive.org): trim dead air, add captions for key terms, export MP4.

**Script source:** each module's `curriculum/.../01-module-blueprint.md` already contains the beats —
the **Analogy**, **Visual Model**, and **Common Misconceptions** sections are your explainer outline.
Structure every video as: *hook → analogy → the mechanism → one real example → "measure/verify first"*.

**Publish:** upload to YouTube (public or unlisted), then:

1. Copy the video ID.
2. In the lesson page, replace the `lo-video-placeholder` card with the embed snippet (the exact
   `<iframe>` is in the lesson's "For the author" collapsible).
3. Register the URL in `youtube-manifest.md`.

## Accessibility

Add captions (YouTube auto-captions, then correct them) and keep casts readable at 90×24. Captions
double as a transcript and help search.

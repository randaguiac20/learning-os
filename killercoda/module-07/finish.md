# Done — your terminal survives you now

In about 30 minutes you:

- Installed tmux and **proved persistence** — a detached session kept a clock ticking with no client
  attached, and `pstree` showed the **server** owning the process.
- Ran the **lifecycle** across the full hierarchy — sessions, named windows, split panes — and felt the
  one rule everyone learns the hard way: `exit` *kills*, **`prefix d`** *detaches*.
- Built a layout **headless** with `new-session -d`, `new-window`, `split-window`, and **`send-keys`** —
  the exact mechanism behind a `workstation.sh` script.
- Wrote an **earned `~/.tmux.conf`** (mode-keys vi · escape-time 0 · tmux-256color · base-index 1 · a
  `prefix r` reload) and confirmed the server accepted it.
- **Observed** every pane with a `list-panes -F` fleet report, **scrubbed scrollback**, inspected the
  **700 socket**, and practiced session hygiene.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
The required project is `workstation.sh` — turn today's headless-build commands into your own daily
one-command workspace.

> The one-sentence takeaway: **M7 decouples your work from your window — from now on your processes
> survive you leaving, the exact property remote engineering (M9) and long-running AI work cannot exist
> without.**

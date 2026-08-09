# Done — you live here now

In ~30 minutes you exercised all four pillars of Linux:

- **Files:** read the **FHS** layout, and proved a name is not the file — the **inode** is (`ls -i`,
  `stat`, and a hard link that survived deleting its first name).
- **Permissions:** set modes in octal, met the **directory-`w` surprise** (deleting edits the
  *directory*), and fixed it with the **sticky bit** — identity × mode bits, first-match.
- **Software:** ran the **apt lifecycle** — investigate, install, inventory with `dpkg -L`, reverse-look
  up with `dpkg -S` — the only sane way software enters a system.
- **Processes:** read the tree with `ps auxf`, drove a job with **job control**, and terminated it by
  exact PID with **SIGTERM** — TERM before KILL, always.

**Back on the lesson page:** do the *Solo Lab* challenges (world-writable sweep, the setgid+sticky shared
space, signals without collateral damage), the *Self-Check*, and the *Mastery checklist*. When every box
is honestly true, Module 04 (Linux Administration) becomes current.

> The one-sentence takeaway: **Containers, clusters, and clouds are these four pillars in new packaging —
> master them here at laptop scale, or debug them blind at production scale later.**

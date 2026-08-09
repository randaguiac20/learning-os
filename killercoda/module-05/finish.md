# Done — you write programs now

In under half an hour you:

- Wrote a **first script** with a `#!/bin/bash` shebang and ran it three ways — `bash file`, the
  execute bit + `./file`, and saw the kernel read the shebang for you.
- Felt the **#1 bug class**: bare `$var` splits and globs; `"$var"` is safe; `'$var'` is literal — the
  minefield of hostile filenames proved it.
- Branched on **exit codes** with `if`/`&&`/`||`, failed honestly to stderr, and buckled the
  **`set -euo pipefail`** seatbelt.
- Factored logic into **functions** with `local`, passed args with `"$@"`, and parsed flags like a real
  tool with **getopts**.
- Guaranteed cleanup with a **`trap … EXIT` + `mktemp`** (no litter, every exit path), and ran the
  **`bash -n` → `shellcheck` → `bash -x`** debugging trio.

**Back on the lesson page:** do the *Solo Lab* (getopts backup, the trap proof, the Steam-bug guards),
the *Self-Check*, and tick the *Mastery checklist*. When every box is honestly true, you've closed
**Stage 2** and Module 06 (Vim) becomes current.

> The one-sentence takeaway: **from here on, everything you know how to *do*, you know how to *encode* —
> and every later module's tooling assumes exactly that.**

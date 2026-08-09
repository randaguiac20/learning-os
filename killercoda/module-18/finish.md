# Done — the workbench is code now

In about 30 minutes you:

- Named the **before** cost — the manual setup a repo needs on a bare machine — and turned it into a
  file's TODO list.
- Wrote a **non-root Dockerfile** (pinned base, `USER dev`) so bind-mounted files aren't root-owned.
- Wrote a valid **`devcontainer.json`** — a `build` base, a **pinned Feature**, a non-root `remoteUser`,
  a forwarded port, and an idempotent `postCreateCommand` — and proved it parses as strict JSON.
- **Materialized** the bench with a real `docker build` and ran the container as the remote user with the
  workspace mounted — then ran the `postCreate` hook by hand, watching the environment assemble.
- Placed hooks on the right side of the **bake/personalize** line, and put a secret behind a **gitignored
  env-file mount** instead of the committed spec.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
When every box is honestly true, you've closed **Stage 5** — and Ship It gains its **bench** tier, the
fourth and final leg of rail / hull / understanding / bench.

> The one-sentence takeaway: **M18 completes the environment-as-code arc — venv → dotfiles → image →
> bench — so a laptop is just glass and the blueprint, in git, is what you actually own.**

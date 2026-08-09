# Step 5 — The bootstrap idea and the two laws

Everything so far builds to **the party trick that's actually infrastructure**: a brand-new machine
becomes *yours* in one command. You won't reset this VM here, but the command is exactly:

```bash
echo 'sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <your-github-username>'
```{{exec}}

That single line **clones** your dotfiles repo (over SSH — M9), **renders** the templates for this
machine's role, **runs** the `run_once` setup scripts, and **lands** every config in place. Minutes to
home, instead of an afternoon of hand-copying.

A `run_once_` script rides *with* the dotfiles and fires exactly once per machine. See the idea — apply
runs it, a second apply stays silent (once means once):

```bash
cat > "$(chezmoi source-path)/run_once_hello.sh" <<'EOF'
#!/bin/bash
set -euo pipefail
echo "run_once fired — baseline setup would happen here"
EOF
```{{exec}}

```bash
chezmoi apply
```{{exec}}

```bash
chezmoi apply
```{{exec}}

The second apply printed nothing new — the run is hash-tracked in chezmoi's state. Because these scripts
execute automatically on **every** future machine, they are **the highest-privilege code you own**:
M5-standard, idempotent, audited.

### The two laws

- **Test the bootstrap like a backup.** An untested bootstrap is a *hope*, not a restore (M4's law). The
  reset-VM drill, quarterly, is what makes "works" a present-tense claim.
- **Never `init --apply` a stranger's repo unread.** Their `run_` scripts execute as *you* — that's code
  execution, not decoration. Fork, read the scripts first, adopt pieces into *your* source.

Inspect the environment one last time — everything here is transparent:

```bash
chezmoi managed
```{{exec}}

```bash
mise ls
```{{exec}}

You installed the managers, put a dotfile under management, drilled the loop, enforced a mode Git can't
store, pinned a runtime, and saw the bootstrap that ties it together. That's Module 10, hands-on.

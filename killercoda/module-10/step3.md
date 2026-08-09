# Step 3 — Drill the loop, then enforce a mode

The daily loop is: **edit the SOURCE → `chezmoi diff` → `apply`**. Add a real improvement to the source
(never to `~/.vimrc` directly):

```bash
echo 'syntax on' >> "$(chezmoi source-path)/dot_vimrc"
```{{exec}}

Preview what would change — **read it** before applying:

```bash
chezmoi diff
```{{exec}}

Reconcile the target to the source, then confirm both lines are now in your real file:

```bash
chezmoi apply
```{{exec}}

```bash
cat ~/.vimrc
```{{exec}}

Now the anti-pattern **on purpose** — edit the *target* and watch chezmoi want to revert it. That "wanting
to undo" is **drift**, and it shows you which direction truth flows:

```bash
echo 'set ruler' >> ~/.vimrc
```{{exec}}

```bash
chezmoi diff
```{{exec}}

Two legitimate exits from drift: `chezmoi apply` (discard the edit — source wins) or `chezmoi add` (accept
it upstream). Accept this one:

```bash
chezmoi add ~/.vimrc
```{{exec}}

### Enforce a mode Git can't store

Git tracks `+x` but never `600`. The `private_` attribute closes that gap. Create an ssh config, add it,
and prove the applied mode:

```bash
mkdir -p ~/.ssh && printf 'Host *\n    ServerAliveInterval 60\n' > ~/.ssh/config && chmod 600 ~/.ssh/config
```{{exec}}

```bash
chezmoi add ~/.ssh/config
```{{exec}}

```bash
stat -c '%a %n' ~/.ssh/config
```{{exec}}

Click **Check** to verify `dot_vimrc` holds your improvement, `~/.vimrc` was applied from it, and the ssh
config is mode `600`.

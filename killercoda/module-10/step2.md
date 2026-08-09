# Step 2 — Put a dotfile under management

chezmoi keeps its **source state** (the truth) in a git repo at `~/.local/share/chezmoi`. Initialise it:

```bash
chezmoi init
```{{exec}}

Create a real dotfile in your home, then copy it **into** the source with `chezmoi add`:

```bash
printf 'set number\n' > ~/.vimrc
```{{exec}}

```bash
chezmoi add ~/.vimrc
```{{exec}}

Look at what chezmoi made. `chezmoi source-path` prints the source directory; list it and notice the
filename it chose:

```bash
ls -la "$(chezmoi source-path)"
```{{exec}}

It became **`dot_vimrc`** — the attribute encoding, live. `dot_` renders back to a leading dot on apply;
Git-safe in the repo, a real dotfile in your home. The inventory of everything under management:

```bash
chezmoi managed
```{{exec}}

> This source directory **is** a git repo. In real life you'd `git remote add` your dotfiles repo and
> `git push` — push is backup (M8). Here we stay local, but the model is identical.

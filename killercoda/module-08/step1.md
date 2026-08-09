# Step 1 — Identity, first repo, atomic commits

Git records **who** made each commit, so set your identity first (this is a one-time global config). If
`git` isn't installed yet, install it:

```bash
command -v git >/dev/null || (apt-get update && apt-get install -y git)
```{{exec}}

```bash
git config --global user.name "Lab User"
git config --global user.email "lab@example.com"
git config --global init.defaultBranch main
```{{exec}}

Now create a repository — a **full repo**, right here on disk:

```bash
mkdir ~/git-lab && cd ~/git-lab && git init
```{{exec}}

Make a file, then check status **before** you stage anything (`status` first, always):

```bash
printf 'set number\n' > .vimrc
```{{exec}}

```bash
git status
```{{exec}}

Stage and commit it — one idea, one commit:

```bash
git add .vimrc && git commit -m "Add vimrc with line numbers"
```{{exec}}

Now a **second, unrelated** change as its **own** commit — atomic commits, not one dump:

```bash
printf 'alias ll="ls -la"\n' > .bashrc
```{{exec}}

```bash
git add .bashrc && git commit -m "Add ll alias to bashrc"
```{{exec}}

```bash
git log --oneline
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- What did `git status` say *before* the `add`, and what changed *after* the commit?
- Two commits, each with one logical change: a commit is a **statement** (chosen content + a caption),
  not an autosave. That deliberateness is the whole point of the staging area.

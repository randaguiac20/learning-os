# Step 2 — Branch and fast-forward merge

A **branch** is a movable pointer — a ~41-byte file holding one commit hash. Create one and move onto it
in a single command:

```bash
cd ~/git-lab && git switch -c test-idea
```{{exec}}

**HEAD** is just a pointer that says "where am I" — look at it:

```bash
cat .git/HEAD
```{{exec}}

You'll see `ref: refs/heads/test-idea`. Now make a commit on this branch:

```bash
printf 'syntax on\n' >> .vimrc
```{{exec}}

```bash
git commit -am "Enable syntax highlighting"
```{{exec}}

*See* the two pointers in the graph:

```bash
git log --graph --oneline --all
```{{exec}}

Switch back to `main` — watch the working tree follow HEAD (your `.vimrc` reverts):

```bash
git switch main
```{{exec}}

```bash
cat .vimrc
```{{exec}}

Now merge. Because `main` never moved, this is a **fast-forward** — a pointer slide, with **no merge
commit**:

```bash
git merge test-idea
```{{exec}}

The branch has served its purpose; delete the pointer (the commits remain):

```bash
git branch -d test-idea
```{{exec}}

```bash
git log --oneline
```{{exec}}

> A fast-forward happens only when history is **linear** — `main` simply catches up to the tip. When two
> branches have genuinely diverged, Git can't slide a pointer and must build a real merge commit. That's
> the next step.

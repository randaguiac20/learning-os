# Step 5 — Your own remote — no network needed

A **remote** is just the same graph on another location. You don't need GitHub to learn the loop — a
**bare** repo (a repo with no working tree, only the database) *is* what GitHub is underneath. Build one
on local disk:

```bash
cd ~/git-lab && git init --bare ~/origin.git
```{{exec}}

Add it as `origin` and push — `-u` sets up tracking so `main` remembers where it came from:

```bash
git remote add origin ~/origin.git
```{{exec}}

```bash
git push -u origin main
```{{exec}}

Confirm the tracking relationship:

```bash
git branch -vv
```{{exec}}

Now **clone** it into a second directory — this is the "server" (or your other machine) getting a full
copy:

```bash
git clone ~/origin.git ~/git-lab-2
```{{exec}}

```bash
cd ~/git-lab-2 && git log --oneline
```{{exec}}

Your complete history is now in two clones plus the bare hub. Prove the sync direction: `fetch` moves the
**`origin/*` bookmark** and never touches your own branch — your `main` only moves when *you* integrate:

```bash
git fetch origin && git branch -vv
```{{exec}}

You just used Git **distributed** — a `push` to a bare repo and a fresh `clone` is exactly the GitHub
loop, with no network and no account. Everything you learned about commits, branches, and merges works
identically once a real remote (M9's SSH) sits at the other end.

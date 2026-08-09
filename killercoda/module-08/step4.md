# Step 4 — Break history, then recover it

Time to earn the reflex that retires panic: destroy a commit on purpose, then bring it back. Make a
commit worth "losing":

```bash
cd ~/git-lab && printf 'important work\n' > notes.txt
```{{exec}}

```bash
git add notes.txt && git commit -m "Add rescue-me notes"
```{{exec}}

```bash
git log --oneline
```{{exec}}

Now the "disaster" — a hard reset throws the commit off `main` (and would discard working changes too, so
`status` first in real life):

```bash
git reset --hard HEAD~1
```{{exec}}

```bash
git log --oneline
```{{exec}}

The commit is gone from `main`... but **nothing referenced is truly lost for ~90 days.** The **reflog** is
your local journal of every place HEAD has been — find the lost commit there:

```bash
git reflog
```{{exec}}

Rescue it onto a new branch. `HEAD@{1}` is where HEAD was one move ago — the commit you just reset away:

```bash
git branch rescue HEAD@{1}
```{{exec}}

```bash
git log --oneline rescue
```{{exec}}

There it is — `Add rescue-me notes`, recovered. The recovery reflex is always the same: **`reflog` →
find the hash → `git branch rescue <hash>`** (or `git reset --hard <hash>`). "I lost my code" is a
missing tool, not a missing feature.

Click **Check** to verify the `rescue` branch holds the recovered commit.

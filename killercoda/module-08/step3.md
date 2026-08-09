# Step 3 — A real merge and a conflict

When two branches change the **same line**, Git can't guess — it writes both truths and asks you. Let's
make that happen on purpose. First a shared starting point:

```bash
cd ~/git-lab && printf 'echo "v1"\n' > app.sh && git add app.sh && git commit -m "Add app.sh printing v1"
```{{exec}}

Diverge: on a `feature` branch, change that line:

```bash
git switch -c feature && printf 'echo "feature"\n' > app.sh && git commit -am "Change app.sh to print feature"
```{{exec}}

Back on `main`, change the **same line** differently:

```bash
git switch main && printf 'echo "main"\n' > app.sh && git commit -am "Change app.sh to print main"
```{{exec}}

Now merge — this **conflicts** (that's expected, don't flinch):

```bash
git merge feature
```{{exec}}

`status` names the conflicted file; look at the markers Git wrote — two truths to choose between:

```bash
git status
```{{exec}}

```bash
cat app.sh
```{{exec}}

Resolve by **choosing** the final content (removing every `<<<<<<<`, `=======`, `>>>>>>>` marker), then
stage and finish the merge — this creates a **merge commit with two parents**:

```bash
printf 'echo "merged"\n' > app.sh
```{{exec}}

```bash
git add app.sh && git commit -m "Merge feature into main"
```{{exec}}

```bash
git log --graph --oneline
```{{exec}}

The graph shows two lines of history converging at your merge commit. A conflict is never a crisis — it's
just a region both sides changed, and `status` always tells you exactly what to do.

Click **Check** to verify the merge commit exists and no conflict markers remain.

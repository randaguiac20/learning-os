# Step 4 — Copy, move, and delete safely

Still inside `~/terminal-lab`. Copy the file, then move-and-rename it — verifying every time:

```bash
cp projects/alpha/notes/day1.md day1-backup.md
```{{exec}}

```bash
ls -R
```{{exec}}

```bash
mv day1-backup.md projects/beta/
```{{exec}}

`mv` both moves AND renames — the same command does both:

```bash
mv projects/beta/day1-backup.md projects/beta/day1-copy.md
```{{exec}}

```bash
ls -R
```{{exec}}

Now delete — **safely**. `rm` has no undo and no trash can, so `ls` first, then use `-i` (prompt) while
learning. These files are throwaway scratch files inside the sandbox:

```bash
touch trash1 trash2 trash3
```{{exec}}

```bash
ls
```{{exec}}

```bash
rm -i trash1
```{{exec}}

```bash
rm trash2 trash3
```{{exec}}

```bash
ls
```{{exec}}

> Rule for life: never run `rm` (and never `rm -rf` at all this month) outside a directory you built for
> throwaway practice. `ls` before `rm`, every time.

Click **Check** to verify the renamed file survived and the scratch files are gone.

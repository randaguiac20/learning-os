# Step 3 — Build a sandbox and a tree

All destructive practice lives in one place: a **sandbox** you create. Make it and move in:

```bash
mkdir ~/terminal-lab
```{{exec}}

```bash
cd ~/terminal-lab
```{{exec}}

```bash
pwd
```{{exec}}

Confirm the prompt now shows `/home/<you>/terminal-lab`. Now build a whole tree with **one** command —
`-p` creates parent directories as needed, and the shell expands `{alpha,beta}` into two names:

```bash
mkdir -p projects/{alpha,beta}/notes
```{{exec}}

See the structure and drop a file into it:

```bash
ls -R
```{{exec}}

```bash
touch projects/alpha/notes/day1.md
```{{exec}}

```bash
ls -R
```{{exec}}

The habit to install now: **verify after every change** with `ls`. That rhythm is the real content of
this module — it's what prevents mistakes once commands start deleting things.

Click **Check** to verify your sandbox tree and file exist.

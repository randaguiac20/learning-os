# Step 5 — Look inside files and get help

Four ways to read a file — whole, paged, start, end — plus the self-help habit that makes you
independent.

```bash
cat /etc/hostname
```{{exec}}

```bash
head -5 /etc/passwd
```{{exec}}

```bash
tail -5 /etc/passwd
```{{exec}}

```bash
wc -l /etc/passwd
```{{exec}}

**Prove the shell expands globs, not the program.** Back in your sandbox, create a few files and `echo`
the pattern — `echo` just prints what the shell already substituted:

```bash
cd ~/terminal-lab && touch a.md b.md c.txt
```{{exec}}

```bash
echo *.md
```{{exec}}

You see `a.md b.md` — the shell expanded `*.md` before any program ran. That's why you `echo` a glob
before letting a destructive command use it.

### The man-page habit (the independence skill)

```bash
man ls
```{{exec}}

Inside `man`: read the **SYNOPSIS** first, search with `/size`, and press **`q`** to quit (a pager is
never frozen — it's waiting). Find what `-S`, `-r`, and `-h` do, then combine them:

```bash
ls -lShr
```{{exec}}

You navigated a real machine, built and reorganised a tree, deleted safely, and taught yourself an
option from the manual. That's Module 02, hands-on.

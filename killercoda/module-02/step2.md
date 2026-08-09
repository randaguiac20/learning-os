# Step 2 — Navigate the filesystem

Paths are the address system. `cd` moves you; `pwd` + `ls` are your eyes.

Go to root and look around — recognise the filesystem tour from Module 01:

```bash
cd /
```{{exec}}

```bash
ls
```{{exec}}

Visit where the programs live, and count them by composing two programs with a pipe:

```bash
cd /usr/bin
```{{exec}}

```bash
ls | wc -l
```{{exec}}

Bare `cd` returns home; `cd -` jumps back to where you just were:

```bash
cd
```{{exec}}

```bash
cd -
```{{exec}}

**Absolute vs relative:** `cd /etc` reaches `/etc` from anywhere (starts at root `/`). A relative path
like `cd ../../etc` depends on where you currently are. Try both and confirm with `pwd` each time.

> `.` = here · `..` = parent · `~` = your home · `-` = previous directory. Learn these four and
> navigation stops needing thought.

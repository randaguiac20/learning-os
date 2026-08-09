# Step 1 — First script and the shebang

A script is just a text file whose first line names its interpreter. Make a workbench and write one:

```bash
mkdir -p ~/learning/scripts && cd ~/learning/scripts
```{{exec}}

```bash
printf '%s\n' '#!/bin/bash' 'echo "Hello from $(hostname) at $(date +%T)"' > hello.sh
```{{exec}}

Run it the first way — hand the file to the interpreter directly (no execute bit needed):

```bash
bash hello.sh
```{{exec}}

Now give it the **execute bit** (Module 03) and run it as a program. The kernel reads the `#!` shebang
and fork/execs `/bin/bash` for you:

```bash
chmod +x hello.sh
```{{exec}}

```bash
./hello.sh
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- `bash hello.sh` ran without `chmod +x`; `./hello.sh` needed it. Why? (The execute bit lets the kernel
  run the file itself.)
- `$(hostname)` and `$(date +%T)` are **command substitution** — a command's output becomes a value.
- The `#!/bin/bash` line is a **contract**, not a comment: it tells the kernel which interpreter runs
  the file. Without it, whatever shell you call it from runs it — by luck.

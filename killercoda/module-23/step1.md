# Step 1 — Install the tools, meet the bench

Every debugger carries a kit. Install yours — the syscall wiretap (`strace`), the library-call tracer
(`ltrace`), the interactive debugger (`gdb`), and `file`:

```bash
apt-get update -qq && apt-get install -y gdb strace ltrace file git
```{{exec}}

Make a throwaway lab directory — all of today's breakage lives here:

```bash
mkdir -p ~/debug-lab && cd ~/debug-lab
```{{exec}}

Confirm the instruments are ready:

```bash
strace -V | head -1
```{{exec}}

```bash
ltrace -V | head -1
```{{exec}}

```bash
gdb --version | head -1
```{{exec}}

You'll reach for **`strace` first** this lab. It needs no source code and cannot be lied to: it reads the
boundary between the program and the kernel, so it shows the file a program *actually* opened and the
address it *actually* dialed — not what a log *claims* happened.

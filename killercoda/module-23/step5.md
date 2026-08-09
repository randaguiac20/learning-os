# Step 5 — Root cause vs symptom, verify the fix

You fixed two **root causes** today: a misplaced config (Step 3) and a flipped operator (Step 4). The
**symptoms** were what you first *saw* — grep's `ENOENT`, a failing test. Rule 9 says a fix isn't a fix
until you re-run the original failure and watch it pass. Do both, together:

```bash
~/debug-lab/report.sh; echo "report exit=$?"
```{{exec}}

```bash
( cd ~/debug-lab/calc && bash test.sh )
```{{exec}}

Both green — the fixes are verified against the exact conditions that failed.

Now taste the other two instruments in your kit. `ltrace` traces **library** calls, one layer above the
syscalls `strace` shows:

```bash
ltrace -e '+puts+printf' ls >/dev/null
```{{exec}}

And `gdb` catches a crash and prints **where** it happened — no source code required. Here bash is asked to
send itself `SIGSEGV`, and gdb prints the backtrace at the moment of death:

```bash
gdb -q -batch -ex run -ex bt --args bash -c 'kill -SEGV $$'
```{{exec}}

That is the whole method in miniature: **read the actual evidence** (the error, the syscall, the
backtrace), form **one** hypothesis, test it with **one** change, and **verify** against the original
symptom. Three instruments, one loop.

Click **CONTINUE** to finish.

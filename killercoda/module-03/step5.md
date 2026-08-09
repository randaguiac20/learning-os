# Step 5 — Processes, jobs, and signals

Processes form a **tree**, and **signals** are the only polite way to talk to them. First see the tree —
`systemd` (PID 1) at the root, down to your shell:

```bash
ps auxf | head -20
```{{exec}}

Start a long-running job in the **background** with `&`:

```bash
sleep 500 &
```{{exec}}

```bash
jobs
```{{exec}}

Job control lets the shell multiplex your terminal. Bring the job to the foreground, then suspend it
with **Ctrl-Z** (type the command, then press Ctrl-Z while it's running):

```bash
fg
```{{exec}}

After pressing **Ctrl-Z**, list jobs — it's now `Stopped` — then resume it in the background:

```bash
jobs
```{{exec}}

```bash
bg
```{{exec}}

Now signals, felt. Find the **exact** PID with `pgrep` (a broad match could kill the wrong process), then
ask it to stop with the default signal, **SIGTERM**:

```bash
pgrep -a sleep
```{{exec}}

```bash
kill -TERM "$(pgrep -n sleep)"
```{{exec}}

```bash
pgrep sleep || echo "terminated cleanly"
```{{exec}}

**SIGTERM asks** — a process can catch it to flush data and clean up. **SIGKILL** (`kill -9`) is
unrefusable: the kernel just stops scheduling it, no cleanup, data at risk. On a bare `sleep` they look
identical, but the moment a process has cleanup to do they differ — so **TERM first, KILL only as a last
resort**. See the whole signal table any time:

```bash
kill -l
```{{exec}}

You read the process tree, drove a job through suspend/background/foreground, and terminated it cleanly
by exact PID. That's the fourth pillar, hands-on.

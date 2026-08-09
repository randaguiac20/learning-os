# Step 3 — A process, from birth to death

A **process** is a program *running*. Let's create one, watch it, and end it — all through the kernel.

Start a background process (it just sleeps for 5 minutes) and note its **PID**:

```bash
sleep 300 &
```{{exec}}

Find it:

```bash
ps aux | grep "[s]leep 300"
```{{exec}}

Inspect its virtual vs resident memory (VSZ vs RSS):

```bash
ps -o pid,vsz,rss,cmd -C sleep
```{{exec}}

Now **terminate** it through the kernel and confirm it's gone:

```bash
pkill -f "sleep 300"
```{{exec}}

```bash
ps aux | grep "[s]leep 300" || echo "gone — the kernel reclaimed it"
```{{exec}}

You just did what an OS does millions of times a day: create a process, schedule it, and reclaim it.

Click **Check** to verify the process is no longer running.

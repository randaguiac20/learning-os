# Step 1 — Meet your machine

Three questions every operator asks first: *what am I on, who is it, and how long has it been up?*

```bash
uname -a
```{{exec}}

```bash
hostnamectl
```{{exec}}

```bash
uptime
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- What is the **kernel** version? (That's the core of the OS.)
- One of these facts comes straight from the kernel; another is read from a file. Which is which?

The `uname` data comes from the kernel itself; the hostname is read from a file (`/etc/hostname`).
You just crossed the user/kernel boundary without noticing — that's the whole point of an OS.

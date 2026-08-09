# Debugging Methodology — hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll debug **real
planted failures the way a senior engineer does** — by method, not by guessing:

- **Read** an error and its exit code instead of theorising.
- **strace** a program to see the syscall it *actually* made (the file it *actually* tried to open).
- **git bisect** a regression buried in a throwaway repo — binary search over history.
- Fix each **root cause** (not the symptom) and **verify** the fix against the original failure.

Everything happens inside a disposable `~/debug-lab/` you build first — nothing outside it is touched.

> The law of this module: **evidence before theory.** Read the *actual* error, aloud, to the end. `strace`
> cannot be lied to — logs claim, syscalls confess.

Click **START** to begin.

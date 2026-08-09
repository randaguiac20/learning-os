# CPU & Memory Performance — hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll install the
performance toolkit, read an **idle** machine with the USE checklist, generate a **CPU load** and watch
the meters move, then **feel the cache** — timing the same work along rows (cache-friendly) versus down
columns (cache-hostile) and seeing the memory wall in the numbers.

**Everything lives in a throwaway `~/perf-lab/` you create**, and the last step **restores the machine**
(no lingering load). The core discipline: *measure first* — the number decides, not the guess.

> **`perf` note:** in a shared browser VM the kernel's `perf` counters are often unavailable (a
> paranoia/permissions gate). This lab reads mechanism with tools that **always** work — `mpstat`,
> `vmstat`, `pidstat`, `/usr/bin/time -v`, and a tiny compiled C timer. Where `perf` *is* available, it
> layers the IPC/cache-miss census on top.

Click **START** to begin.

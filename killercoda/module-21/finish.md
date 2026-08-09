# Done — you measured, you didn't guess

In ~30 minutes you:

- Installed the **performance toolkit** and read the machine's spec sheet (cores, threads, cache sizes).
- Ran the **60-second USE checklist** on an idle box — `uptime`, `vmstat`, `free -h`, `mpstat`, PSI — and
  learned your baseline.
- Generated a **CPU load** with `stress-ng` and measured it with `mpstat`: `%idle` cratered — utilization
  is the *U* in USE, recorded as evidence.
- **Felt the cache**: the same 64 MB sum ran several times faster along rows than down columns — the
  memory wall in your own numbers.
- Contrasted **memory-bound vs CPU-bound** load and **restored** the machine.

**Back on the lesson page:** do the *Solo Lab* (classify workloads, prove a mechanism, drive the
performance ladder, Make It Fast), the *Self-Check* recall, and tick the *Mastery checklist*. When every
box is honestly true, M21 is done and **Module 22 (GPU & NPU)** becomes current — the same thinking on
parallel silicon.

> The one-sentence takeaway: **the profile is the permission slip — the ladder in your head, the
> profiler in your hand, the mechanism named before the fix.**

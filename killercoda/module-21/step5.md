# Step 5 — Memory-bound vs CPU-bound, then restore

Step 3 was **CPU-bound**: `%idle` cratered while memory stayed calm. Now feel a **memory-bound** load —
a different resource, a different meter. This burst is short and self-limiting:

```bash
stress-ng --vm 2 --vm-bytes 75% --timeout 10s &
```{{exec}}

Watch the memory resource strain — `free` shrinks, `si/so` may move as cold pages get swapped:

```bash
vmstat 1 5
```{{exec}}

The honest warning — PSI `some` climbs *before* any cliff:

```bash
cat /proc/pressure/memory
```{{exec}}

Let it finish, then confirm `available` recovers once the load ends:

```bash
wait
```{{exec}}

```bash
free -h
```{{exec}}

**The lesson:** CPU-bound pins `%idle` low with calm memory; memory-bound pushes `si/so` and PSI while
the CPU may sit *waiting*. USE points you at the guilty resource before you ever open a profiler.

Now **restore the machine** — leave nothing running:

```bash
pkill stress-ng 2>/dev/null; echo "clean"
```{{exec}}

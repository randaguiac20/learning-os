# Step 2 — The 60-second USE checklist (idle baseline)

Before profiling any code, triage the whole system. Gregg's **USE** method — for each resource:
Utilization, Saturation, Errors. Run it on the **idle** machine so you know what "normal" looks like
here (anomaly detection needs a baseline).

Demand over the last 1 / 5 / 15 minutes:

```bash
uptime
```{{exec}}

Live CPU / memory / IO — watch `r` (run queue), `si/so` (swap!), `wa` (iowait), `bi/bo` (disk):

```bash
vmstat 1 3
```{{exec}}

Memory — read the **available** column, NOT "free" (the page cache is not waste):

```bash
free -h
```{{exec}}

Per-CPU busy vs idle on an idle box (note the high `%idle`):

```bash
mpstat 1 3
```{{exec}}

The honest modern pressure metric — stall time, near zero when idle:

```bash
cat /proc/pressure/cpu /proc/pressure/memory
```{{exec}}

**Note your idle baseline:** a high `%idle`, near-zero PSI `some` values, no swap. In the next step you
will drive a load and watch every one of these move.

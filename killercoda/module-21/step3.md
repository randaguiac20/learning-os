# Step 3 — Generate a CPU load and measure it

Build your sandbox, then make every core busy for 12 seconds while `mpstat` captures the truth:

```bash
mkdir -p ~/perf-lab && cd ~/perf-lab
```{{exec}}

```bash
stress-ng --cpu "$(nproc)" --timeout 12s &
```{{exec}}

Capture 5 seconds of per-CPU stats to a log while the load runs, then wait for stress-ng to finish:

```bash
mpstat 1 5 | tee ~/perf-lab/cpu-load.log
```{{exec}}

```bash
wait
```{{exec}}

Now **record the measurement**. The `Average:` line's last field is `%idle` — pull it out and write a
structured record (this is your evidence, produced by running the command):

```bash
idle=$(awk '/^Average:/{print $NF}' ~/perf-lab/cpu-load.log)
printf 'workload=stress-ng-cpu\ntool=mpstat\nidle_percent=%s\nresource=CPU\nverdict=utilization-high\n' "$idle" | tee -a ~/perf-lab/measurements.log
```{{exec}}

`%idle` should crater toward 0 while stress-ng ran — **utilization is high, the CPU is the busy
resource** (the *U* in USE, measured). If you have `perf`, `perf stat stress-ng --cpu 1 -t 3s` shows a
high IPC — a fed core doing real work.

Click **Check** to verify your measurement log has the mpstat capture and the recorded fields.

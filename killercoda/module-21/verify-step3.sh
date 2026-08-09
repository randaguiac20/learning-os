#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the CPU-load measurement was captured and recorded.
lab="$HOME/perf-lab"
log="$lab/cpu-load.log"
rec="$lab/measurements.log"
[ -d "$lab" ] || { echo "Sandbox ~/perf-lab not found — create it with: mkdir -p ~/perf-lab"; exit 1; }
[ -s "$log" ] || { echo "cpu-load.log missing/empty — capture it with: mpstat 1 5 | tee ~/perf-lab/cpu-load.log"; exit 1; }
grep -qi "%idle" "$log" || { echo "cpu-load.log has no mpstat data (no %idle header) — re-run the mpstat capture in Step 3."; exit 1; }
grep -q "^Average:" "$log" || { echo "cpu-load.log has no 'Average:' summary line — let mpstat finish all 5 samples."; exit 1; }
[ -s "$rec" ] || { echo "measurements.log not found — record the measurement with the printf command in Step 3."; exit 1; }
for field in "workload=stress-ng-cpu" "tool=mpstat" "resource=CPU" "verdict="; do
  grep -q "$field" "$rec" || { echo "measurements.log is missing the field '$field' — re-run the record command in Step 3."; exit 1; }
done
grep -Eq "idle_percent=[0-9]+([.][0-9]+)?" "$rec" || { echo "measurements.log has no numeric idle_percent — the awk pull failed; re-run the record command after mpstat finishes."; exit 1; }
echo "Verified: mpstat captured the CPU load and measurements.log holds workload/tool/idle_percent/resource/verdict. Measure-first working."
exit 0

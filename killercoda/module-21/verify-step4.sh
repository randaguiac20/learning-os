#!/bin/bash
# Killercoda step verifier: pass when both locality timings exist and the recorded faster verdict matches them.
lab="$HOME/perf-lab"
log="$lab/locality.log"
[ -s "$log" ] || { echo "locality.log missing/empty — run the row and col timings in Step 4."; exit 1; }
row=$(awk '/^row_major_seconds/{print $2}' "$log" | tail -n1)
col=$(awk '/^col_major_seconds/{print $2}' "$log" | tail -n1)
[ -n "$row" ] || { echo "No row_major_seconds timing — run: ~/perf-lab/locality row | tee -a ~/perf-lab/locality.log"; exit 1; }
[ -n "$col" ] || { echo "No col_major_seconds timing — run: ~/perf-lab/locality col | tee -a ~/perf-lab/locality.log"; exit 1; }
faster=$(awk -F= '/^faster=/{print $2}' "$log" | tail -n1)
[ -n "$faster" ] || { echo "No recorded verdict — record which was faster with: echo \"faster=row\" | tee -a ~/perf-lab/locality.log"; exit 1; }
# determine which timing is actually smaller and require the recorded verdict to match (self-consistent)
actual=$(awk -v r="$row" -v c="$col" 'BEGIN{ print (r <= c) ? "row" : "col" }')
if [ "$faster" != "$actual" ]; then
  echo "Recorded faster=$faster but row=$row s, col=$col s → the faster run was '$actual'. Re-read the numbers and record: echo \"faster=$actual\" | tee -a ~/perf-lab/locality.log"
  exit 1
fi
echo "Verified: row=$row s vs col=$col s recorded, and faster=$faster matches the numbers. You felt the cache."
exit 0

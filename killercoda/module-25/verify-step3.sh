#!/bin/bash
# Killercoda step verifier: pass (exit 0) when prometheus.yml declares the metrics-app scrape job.
lab="$HOME/obs-lab"
cfg="$lab/prometheus.yml"
[ -d "$lab" ] || { echo "Sandbox ~/obs-lab not found — create it in Step 1 with: mkdir -p ~/obs-lab"; exit 1; }
[ -s "$cfg" ] || { echo "prometheus.yml missing/empty — write it with the here-doc in Step 3."; exit 1; }
grep -Eq '^[[:space:]]*scrape_configs:' "$cfg" || { echo "prometheus.yml has no 'scrape_configs:' block — re-write it as shown in Step 3."; exit 1; }
grep -Eq 'job_name:[[:space:]]*["'\'']?metrics-app["'\'']?' "$cfg" || { echo "No 'job_name: metrics-app' in prometheus.yml — add the metrics-app job in Step 3."; exit 1; }
grep -Eq 'localhost:8000' "$cfg" || { echo "The metrics-app job must target localhost:8000 (your app from Step 2) — fix the targets list in Step 3."; exit 1; }
echo "Verified: prometheus.yml declares the metrics-app job scraping localhost:8000. The scrape list is your inventory."
exit 0

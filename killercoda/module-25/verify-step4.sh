#!/bin/bash
# Killercoda step verifier: pass (exit 0) when Prometheus is running and a scrape target is up == 1.
api="localhost:9090/api/v1/query?query=up"

# 1) Prometheus itself must be reachable and answering the query API.
resp="$(curl -s --max-time 5 "$api")"
[ -n "$resp" ] || { echo "Prometheus is not answering on localhost:9090 — start it in Step 4 with: nohup ./prometheus --config.file=prometheus.yml & (then wait ~8s)."; exit 1; }
echo "$resp" | grep -q '"status":"success"' || { echo "Prometheus query API did not return success — check that it started against prometheus.yml and give it a few seconds to scrape."; exit 1; }

# 2) At least one target must have scraped successfully: a value of exactly "1".
if echo "$resp" | grep -Eq '"value":\[[0-9.]+,"1"\]'; then
  echo "Verified: Prometheus is up and at least one target reports up == 1. 'up' is the cheapest series you own."
  exit 0
fi

echo "Prometheus is running but no target is up == 1 yet. Confirm your app is alive (curl -s localhost:8000/metrics), then wait for the next scrape and Check again."
exit 1

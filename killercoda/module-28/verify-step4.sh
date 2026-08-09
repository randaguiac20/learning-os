#!/bin/bash
# Killercoda step verifier: dynamic batching measured — results file exists and batched beat naive on throughput.
res="$HOME/ai-serve/results.json"
base="http://localhost:8000"

# 0. The batched server must still be healthy.
code=$(curl -s -o /dev/null -w '%{http_code}' "$base/healthz")
if [ "$code" != "200" ]; then
  echo "GET /healthz did not return 200 (got '$code') — restart the batched server from Step 4."
  exit 1
fi

# 1. The benchmark results file must exist.
[ -f "$res" ] || {
  echo "No results file at ~/ai-serve/results.json — run the benchmark: cd ~/ai-serve && python3 bench.py"
  exit 1
}

# 2. Batched throughput must exceed naive throughput (the batching law, measured).
python3 - "$res" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))
nb = d["naive"]["throughput"]
bt = d["batched"]["throughput"]
if not (bt > nb):
    print(f"Batched throughput ({bt:.1f} req/s) did NOT beat naive ({nb:.1f} req/s) — re-run bench.py under load.")
    sys.exit(1)
print(f"Verified: batched {bt:.1f} req/s beat naive {nb:.1f} req/s ({bt/nb:.1f}x). "
      "Throughput bought with batching, measured on your own screen.")
sys.exit(0)
PY
exit $?

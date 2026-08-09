#!/bin/bash
# Killercoda step verifier: pass (exit 0) when reach.py wrote reach_result.json AND the graph
# reachability + walk-count answers match the expected values for the diamond DAG.
lab="$HOME/math-lab"
rf="$lab/reach_result.json"
[ -f "$rf" ] || { echo "reach_result.json not found in ~/math-lab — run: python3 reach.py"; exit 1; }

python3 - "$rf" <<'PY'
import json, sys
try:
    r = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse reach_result.json:", e); sys.exit(1)

reachable = r.get("reachable_from_0")
walks = r.get("walks_0_to_3_len2")

if reachable is None or walks is None:
    print("reach_result.json is missing a field — re-run the shipped reach.py."); sys.exit(1)

# Diamond DAG 0->1, 0->2, 1->3, 2->3: all nodes reachable from 0; two length-2 walks 0->3.
if sorted(int(x) for x in reachable) != [0, 1, 2, 3]:
    print(f"reachable_from_0 = {reachable}, expected [0, 1, 2, 3] — restore the shipped reach.py."); sys.exit(1)

if int(walks) != 2:
    print(f"walks_0_to_3_len2 = {walks}, expected 2 (via node 1 and via node 2) — restore the shipped reach.py."); sys.exit(1)

print("Verified: all nodes reachable from 0, and 2 length-2 walks 0->3 counted by matrix powers. The graph↔matrix bridge works.")
PY

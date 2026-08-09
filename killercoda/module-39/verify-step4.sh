#!/bin/bash
# Killercoda step verifier: pass (exit 0) when pool.py wrote pool_result.json AND max-pooling halved
# the image (64x64 -> 32x32) with the blur and sharpen kernels applied.
lab="$HOME/vision-lab"
rf="$lab/pool_result.json"
[ -f "$rf" ] || { echo "pool_result.json not found in ~/vision-lab — run: python3 pool.py"; exit 1; }

python3 - "$rf" <<'PY'
import json, sys
try:
    r = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse pool_result.json:", e); sys.exit(1)

inp   = r.get("input_shape")
pooled= r.get("pooled_shape")
size  = r.get("pool_size")

if inp is None or pooled is None or size is None:
    print("pool_result.json is missing a field — re-run the shipped pool.py."); sys.exit(1)

if inp != [64, 64]:
    print(f"input_shape={inp}, expected [64, 64] — restore the shipped pool.py."); sys.exit(1)

# Pooling with size=2 must halve each spatial dimension.
expected = [inp[0] // size, inp[1] // size]
if pooled != expected:
    print(f"pooled_shape={pooled}, expected {expected} for pool_size={size} — the downsample is wrong. "
          "Check the max_pool block indexing."); sys.exit(1)

if not (r.get("blur_applied") and r.get("sharpen_applied")):
    print("blur/sharpen not both applied — re-run the shipped pool.py."); sys.exit(1)

print(f"Verified: max-pool downsampled {inp} -> {pooled} (halved by pool_size={size}), blur + sharpen applied. "
      "That size reduction is what lets a CNN stack many layers cheaply.")
PY

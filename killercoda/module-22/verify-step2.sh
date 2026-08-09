#!/bin/bash
# Killercoda step verifier: the roofline classifier runs and labels each kernel correctly.
lab="$HOME/gpu-lab"
cd "$lab" 2>/dev/null || { echo "Sandbox ~/gpu-lab not found — start from Step 1 (mkdir -p ~/gpu-lab)."; exit 1; }
[ -f ai.py ] || { echo "ai.py not found — write the classifier as shown in Step 2."; exit 1; }

out="$(python3 ai.py 2>&1)" || { echo "ai.py failed to run:"; echo "$out"; exit 1; }

echo "$out" | grep -q "ridge point" || { echo "Output missing the ridge point line — re-check ai.py."; exit 1; }
echo "$out" | grep -Eq "matmul_4096.*COMPUTE-BOUND" || { echo "matmul_4096 should be COMPUTE-BOUND (intensity climbs above the ridge). Re-check ai.py."; exit 1; }
echo "$out" | grep -Eq "saxpy.*MEMORY-BOUND"       || { echo "saxpy should be MEMORY-BOUND (intensity far below the ridge). Re-check ai.py."; exit 1; }
echo "$out" | grep -Eq "llm_decode.*MEMORY-BOUND"  || { echo "llm_decode should be MEMORY-BOUND (reads every weight per token). Re-check ai.py."; exit 1; }

echo "Verified: the roofline classifier runs — matmul is compute-bound; saxpy and llm_decode are memory-bound. That IS why AI inference is bandwidth-limited."
exit 0

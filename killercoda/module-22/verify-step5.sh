#!/bin/bash
# Killercoda step verifier: the break-even script prints a crossover, and the small
# sizes favor the CPU while the large sizes favor the GPU (the transfer tax).
lab="$HOME/gpu-lab"
cd "$lab" 2>/dev/null || { echo "Sandbox ~/gpu-lab not found — start from Step 1."; exit 1; }
[ -f breakeven.py ] || { echo "breakeven.py not found — write it as shown in Step 5."; exit 1; }

out="$(python3 breakeven.py 2>&1)" || { echo "breakeven.py failed to run:"; echo "$out"; exit 1; }

echo "$out" | grep -Eq "crossover: the GPU first wins at N = [0-9]+" || { echo "No crossover line printed — re-check breakeven.py."; exit 1; }

# The smallest size must favour the CPU (transfer + launch outweigh the tiny compute).
echo "$out" | grep -E "^\s*64 " | grep -q "CPU" || { echo "At N=64 the CPU should win (transfer tax dominates). Re-check breakeven.py."; exit 1; }
# The largest size must favour the GPU (throughput dominates once data is worth shipping).
echo "$out" | grep -E "^\s*8192 " | grep -q "GPU" || { echo "At N=8192 the GPU should win. Re-check breakeven.py."; exit 1; }

echo "Verified: small matmuls favour the CPU, large ones the GPU, and the script reports the crossover. The transfer tax, made concrete."
exit 0

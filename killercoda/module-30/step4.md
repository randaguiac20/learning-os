# Step 4 — Graphs as matrices: reachability by matrix powers

**The bridge.** A **graph** (vertices + edges — discrete math) can be written as an **adjacency matrix**
where cell `[i][j] = 1` if there's an edge `i → j` (linear algebra). Then the magic: **`Aⁿ[i][j]` counts the
length-`n` walks** from `i` to `j`, and summing powers reveals which nodes are **reachable**.

Build a small directed graph — a "diamond" build order — and let matrix powers do the reasoning:

```bash
cd ~/math-lab
```{{exec}}

```bash
cat > reach.py <<'EOF'
import json
import numpy as np

# 4 tasks; edges: 0->1, 0->2, 1->3, 2->3  (a diamond DAG — a valid build order exists)
A = np.array([[0, 1, 1, 0],
              [0, 0, 0, 1],
              [0, 0, 0, 1],
              [0, 0, 0, 0]])
n = A.shape[0]

# length-2 walks from 0 to 3: via node 1 AND via node 2 -> expect 2
walks_0_to_3_len2 = int(np.linalg.matrix_power(A, 2)[0][3])

# Reachability: (I + A + A^2 + ... + A^(n-1))[i][j] > 0  means j is reachable from i.
reach = np.zeros((n, n), dtype=int)
P = np.eye(n, dtype=int)
for _ in range(n):
    reach += P
    P = P @ A
reachable_from_0 = [j for j in range(n) if reach[0][j] > 0]

result = {
    "reachable_from_0": reachable_from_0,       # expect [0, 1, 2, 3]
    "walks_0_to_3_len2": walks_0_to_3_len2,      # expect 2
}
with open("reach_result.json", "w") as f:
    json.dump(result, f, indent=2)
print(json.dumps(result, indent=2))
EOF
```{{exec}}

```bash
python3 reach.py
```{{exec}}

Every node is **reachable from 0** (`[0, 1, 2, 3]`), and there are **2** length-2 walks from 0 to 3 (via node
1 and via node 2) — found purely by **matrix multiplication**. No cycle means a valid build order exists; a
cycle would mean a circular dependency and none — exactly the systemd/build failure you'd debug (M15/M23),
now a graph property.

Click **Check** to verify `reach_result.json` matches the expected reachable set and walk count.

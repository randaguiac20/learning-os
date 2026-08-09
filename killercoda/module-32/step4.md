# Step 4 — Dynamic programming from a slow recursion

**Dynamic programming (DP)** is not a special trick — it is *"a slow recursion with the answers
remembered."* Naive recursive Fibonacci recomputes overlapping subproblems exponentially often (O(2ⁿ));
**memoize** each subproblem's answer and it collapses to O(n). That collapse *is* DP.

Write the module — naive Fibonacci, memoized Fibonacci, and bottom-up coin change:

```bash
cat > ~/dsa-lab/dp.py <<'PY'
def fib_naive(n):                       # O(2^n): recomputes overlapping subproblems
    if n < 2: return n
    return fib_naive(n - 1) + fib_naive(n - 2)

def fib_memo(n, cache=None):            # O(n): each subproblem computed once
    if cache is None: cache = {}
    if n < 2: return n
    if n not in cache:
        cache[n] = fib_memo(n - 1, cache) + fib_memo(n - 2, cache)
    return cache[n]

def coin_change(coins, amount):
    """Fewest coins to make amount, or -1. Bottom-up DP (tabulation)."""
    best = [0] + [float("inf")] * amount
    for a in range(1, amount + 1):
        for c in coins:
            if c <= a:
                best[a] = min(best[a], best[a - c] + 1)
    return best[amount] if best[amount] != float("inf") else -1
PY
```{{exec}}

Measure the blowup, then confirm correctness on known inputs:

```bash
cd ~/dsa-lab && python3 - <<'PY'
import time
from dp import fib_naive, fib_memo, coin_change

t = time.perf_counter(); fib_naive(30); print(f"fib_naive(30): {time.perf_counter()-t:.4f}s  (exponential)")
t = time.perf_counter(); fib_memo(30);  print(f"fib_memo(30):  {time.perf_counter()-t:.6f}s  (linear)")

assert fib_memo(30) == 832040
assert coin_change([1, 3, 4], 6) == 2      # 3+3, not 4+1+1
assert coin_change([2], 3) == -1           # impossible with only 2s
print("DP correct: fib memoized, coin_change on known inputs.")
PY
```{{exec}}

**Read the two timings:** `fib_naive(30)` is measurably slow (it makes ~2.7 million calls);
`fib_memo(30)` is near-instant (it makes ~30). Same recursion — the only change is *remembering*
overlapping subproblems. `coin_change` is the bottom-up form (**tabulation**): fill a table from the
base case up.

Click **Check** to verify your DP solution on known inputs.

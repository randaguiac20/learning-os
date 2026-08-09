# Step 2 — O(n) vs O(n²): see the curve

Big-O is not a theory you take on faith — you can **measure** it. The same task, counting how many
numbers appear in a collection, done two ways: a **nested loop** over a list (O(n²)) versus a membership
test against a **set** (O(n)).

```bash
cd ~/dsa-lab && python3 - <<'PY'
import time

def timed(fn, n):
    data = list(range(n))
    t = time.perf_counter(); fn(data); return time.perf_counter() - t

def quadratic(data):                 # O(n^2): for each item, scan the whole list
    found = 0
    for x in data:
        if x in list(data):          # 'in list' is an O(n) scan, inside an O(n) loop
            found += 1
    return found

def linear(data):                    # O(n): build a set once, then O(1) lookups
    s = set(data)
    return sum(1 for x in data if x in s)

print(f"{'n':>6}  {'O(n^2)':>10}  {'O(n)':>10}")
for n in (1000, 2000, 4000, 8000):
    print(f"{n:>6}  {timed(quadratic, n):>9.4f}s  {timed(linear, n):>9.5f}s")
PY
```{{exec}}

**Read the two columns:**

- When *n* **doubles**, the **O(n²)** time roughly **quadruples** (2² = 4×) — the parabola.
- The **O(n)** time barely moves — it grows in step with *n*.

That gap — a list scan inside a loop versus a set — is the single most common real-world performance
bug. You just turned *"a set is faster"* from a claim into a **number you measured**. The rule of this
module: **derive** the big-O from the code, then **measure** it to confirm — never assert.

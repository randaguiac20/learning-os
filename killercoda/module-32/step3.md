# Step 3 — Binary search + a sort, checked against `sorted()`

**Binary search** compares the target to the middle element and discards half the range each step —
O(log n) — but it only works on **sorted** input. **Merge sort** is a stable O(n log n)
divide-and-conquer sort. Build both, then confirm them against Python's own `sorted()`.

Write the module:

```bash
cat > ~/dsa-lab/search_sort.py <<'PY'
def binary_search(arr, target):
    """Return the index of target in a SORTED arr, or -1. O(log n)."""
    lo, hi = 0, len(arr) - 1
    while lo <= hi:
        mid = (lo + hi) // 2
        if arr[mid] == target: return mid
        if arr[mid] < target:  lo = mid + 1     # discard the left half
        else:                  hi = mid - 1      # discard the right half
    return -1

def merge_sort(arr):
    """Stable O(n log n) divide-and-conquer sort."""
    if len(arr) <= 1: return arr[:]
    mid = len(arr) // 2
    left, right = merge_sort(arr[:mid]), merge_sort(arr[mid:])
    out, i, j = [], 0, 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]: out.append(left[i]); i += 1
        else:                   out.append(right[j]); j += 1
    return out + left[i:] + right[j:]
PY
```{{exec}}

Test it — your sort must match `sorted()`, and every search must land the right index:

```bash
cd ~/dsa-lab && python3 - <<'PY'
import random
from search_sort import binary_search, merge_sort

data = [random.randint(0, 999) for _ in range(200)]
assert merge_sort(data) == sorted(data), "merge_sort disagrees with sorted()!"

s = sorted(data)
for t in (s[0], s[len(s)//2], s[-1]):
    assert s[binary_search(s, t)] == t, "binary_search returned a wrong index!"
print("binary_search + merge_sort correct — matches Python's sorted().")
PY
```{{exec}}

Now **break the invariant** to feel why sorted order matters — run binary search on the *unsorted* data
and watch it miss values that are present:

```bash
cd ~/dsa-lab && python3 -c "from search_sort import binary_search; d=[5,2,9,1,7]; print('index of 9 in UNSORTED:', binary_search(d, 9))"
```{{exec}}

It returns `-1` even though `9` is there: *"the target is larger than the middle"* tells you nothing on
unsorted data, so the halving is invalid. Sorted order is the invariant the algorithm relies on.

Click **Check** to verify your `binary_search` against a fixed test set.

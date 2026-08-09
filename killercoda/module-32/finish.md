# Done — you can measure the cost now

In ~30 minutes you:

- Built a **stack** (LIFO), a **queue** (FIFO), and a **hash-map counter** by hand, and named what each
  costs.
- Watched an **O(n) solution beat an O(n²) one on the clock** — the list-vs-set gap, the most common
  real-world performance bug, measured.
- Wrote a **binary search** (and felt why it needs sorted input) and a **merge sort** that agree with
  Python's own `sorted()`.
- **Derived dynamic programming** by memoizing naive Fibonacci — O(2ⁿ) collapsing to O(n) — and solved
  coin change bottom-up.
- Traced **BFS and DFS reachability** on a graph, and saw BFS return the shortest path.

The habit that carries forward: **derive** each big-O from the code, then **measure** it to confirm — an
asserted complexity you haven't timed is a guess.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back), work the *Solo Lab* challenges
(the O(n²) bug hunt, the degenerate BST, deriving DP yourself, and recognizing NP-completeness), and
tick the *Mastery checklist*. When every box is honestly true, you've closed **Stage 11** and Module 33
(Databases & SQL) becomes current — where these trees and hash tables become database indexes.

> The one-sentence takeaway: **choose the right container for the operation that dominates, know its
> cost by deriving and measuring it, and recognize when a problem is NP-complete so you approximate
> instead of chase.**

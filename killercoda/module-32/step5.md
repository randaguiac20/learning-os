# Step 5 — Graphs: BFS/DFS reachability

A **graph** is M30's vertices and edges as running code. Here it's an **adjacency list** — a dict
mapping each vertex to its neighbours. Two ways to ask *"can I get from A to F?"*: **BFS**
(breadth-first search, a **queue**, finds the shortest path in an unweighted graph) and **DFS**
(depth-first search, recursion / a **stack**, plunges down one branch first).

```bash
cd ~/dsa-lab && python3 - <<'PY'
from collections import deque

graph = {"A": ["B", "C"], "B": ["D"], "C": ["E"], "D": ["F"], "E": [], "F": []}

def bfs_reachable(g, start, goal):       # queue → shortest path in an unweighted graph
    seen, q = {start}, deque([[start]])
    while q:
        path = q.popleft()
        if path[-1] == goal: return path
        for nxt in g[path[-1]]:
            if nxt not in seen:
                seen.add(nxt); q.append(path + [nxt])
    return None

def dfs_reachable(g, start, goal, seen=None):   # recursion (a stack) → deep first
    seen = seen or set(); seen.add(start)
    if start == goal: return True
    return any(dfs_reachable(g, n, goal, seen) for n in g[start] if n not in seen)

print("BFS shortest path A -> F:", bfs_reachable(graph, "A", "F"))   # ['A','B','D','F']
print("DFS can reach A -> F?   :", dfs_reachable(graph, "A", "F"))   # True
print("DFS can reach E -> A?   :", dfs_reachable(graph, "E", "A"))   # False (E is a dead end)
PY
```{{exec}}

**Read the output:**

- **BFS** returns the actual **shortest** path (`A → B → D → F`) because it explores level by level — the
  first time it reaches the goal, it did so by the fewest edges.
- **DFS** answers *reachable?* by plunging down one branch before backtracking. From `E` (a dead end),
  nothing is reachable, so `E → A` is `False`.

Routing a map, resolving package dependencies (like `apt` or Docker layers), and *"six degrees of
separation"* are all **one** traversal — half of algorithm design is **recognizing** a problem as a
graph problem. Add weights to the edges and BFS becomes **Dijkstra**, running on a heap (priority
queue).

# Step 1 — Stack, queue & a hash-map counter

Three of the simplest containers, built by hand. A **stack** is LIFO (last in, first out) — the call
stack, undo, DFS. A **queue** is FIFO (first in, first out) — print jobs, BFS. A **hash table**
(Python's `dict`) is the workhorse: O(1) average lookup and update.

First confirm the interpreter is here, then make a throwaway directory:

```bash
python3 --version
```{{exec}}

```bash
mkdir -p ~/dsa-lab && cd ~/dsa-lab
```{{exec}}

Build the stack and queue, and count words with a `dict`:

```bash
python3 - <<'PY'
class Stack:          # LIFO — last in, first out
    def __init__(self): self._items = []
    def push(self, x):  self._items.append(x)   # O(1) amortized
    def pop(self):      return self._items.pop() # O(1)
    def peek(self):     return self._items[-1]   # O(1)

class Queue:          # FIFO — first in, first out
    def __init__(self): self._items = []
    def enqueue(self, x): self._items.append(x)     # O(1)
    def dequeue(self):    return self._items.pop(0) # O(n) on a list — a real deque is O(1)

s = Stack(); [s.push(i) for i in (1, 2, 3)]
print("stack pops:", s.pop(), s.pop())                 # 3 2  (LIFO)
q = Queue(); [q.enqueue(i) for i in (1, 2, 3)]
print("queue dequeues:", q.dequeue(), q.dequeue())     # 1 2  (FIFO)

counts = {}                                            # a hash table — O(1) average per update
for word in "the cat the dog the cat".split():
    counts[word] = counts.get(word, 0) + 1
print("counts:", counts)                               # {'the': 3, 'cat': 2, 'dog': 1}
PY
```{{exec}}

**Read the output and notice:**

- The stack **reverses** order (LIFO): pushed 1,2,3 → popped 3,2.
- The queue **preserves** order (FIFO): enqueued 1,2,3 → dequeued 1,2.
- The counter touches each word once and each `dict` update is O(1) average — **total O(n)**. Do the
  same with a list of pairs and each update becomes an O(n) scan — the same task, quadratic.

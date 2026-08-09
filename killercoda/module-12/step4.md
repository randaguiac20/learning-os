# Step 4 — Functions and a data structure

Two big ideas at once. A **function** is a named, reusable unit of logic with its own scope — and it
**returns** a value (returning *composes*; printing is a dead end). A **dict** is a data structure that
maps keys to values — perfect for counting. Build a word-frequency counter:

```bash
cat > ~/learning/py/wordfreq.py <<'EOF'
text = "the quick brown fox the lazy dog the fox"

def count_words(t):
    counts = {}                            # a dict: word -> count
    for w in t.split():
        counts[w] = counts.get(w, 0) + 1   # .get(key, default) — no KeyError
    return counts                          # return the result so callers can use it

counts = count_words(text)
top = max(counts, key=counts.get)          # the key with the biggest count
print(f"most common: {top} ({counts[top]})")
EOF
```{{exec}}

```bash
python3 ~/learning/py/wordfreq.py
```{{exec}}

It prints `most common: the (3)` — the word `the` appears three times. Notice the pieces working together:

- **`def count_words(t):`** — a function; `t` and `counts` are *local* names that live only inside it.
- **`counts.get(w, 0)`** — read the current count, defaulting to `0` the first time a word is seen.
- **`return counts`** — hands the dict back; the caller then finds the most common key.

Swap `return` for a `print` and the caller would receive `None` — the return-vs-print distinction, felt.

Click **Check** to verify your function + dict report the most common word.

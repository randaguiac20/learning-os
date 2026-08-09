# Step 3 — Build the vocabulary

A model doesn't consume strings — it consumes integer ids. Turn the whole training corpus into a
**vocabulary** (the sorted set of unique tokens) and a **token → id** map. Write the tokenizer:

```bash
cat > ~/nlp-lab/tokenizer.py <<'PY'
import json
from corpus import TRAIN

def normalize(text):
    # lowercase; replace any non-alphanumeric character with a space
    return "".join(c.lower() if (c.isalnum() or c.isspace()) else " " for c in text)

# collect every unique token across the training sentences
tokens = set()
for text, _label in TRAIN:
    tokens.update(normalize(text).split())

vocab = sorted(tokens)                            # deterministic, alphabetical order
token_to_id = {tok: i for i, tok in enumerate(vocab)}   # id = position in the sorted vocab

with open("vocab.json", "w") as f:
    json.dump({"vocab_size": len(vocab), "token_to_id": token_to_id}, f, indent=2)

print("vocab_size :", len(vocab))
print("first 10   :", vocab[:10])
print("'movie' -> ", token_to_id.get("movie"))
print("'great' -> ", token_to_id.get("great"))
PY
```{{exec}}

Run it — this writes `vocab.json`:

```bash
cd ~/nlp-lab && python3 tokenizer.py
```{{exec}}

Inspect the artifact — how many tokens, and which id did each word get?

```bash
python3 -c "import json;v=json.load(open('vocab.json'));print('vocab_size:',v['vocab_size']);print('movie ->',v['token_to_id']['movie'])"
```{{exec}}

Because the vocabulary is **sorted**, each token's id is just its alphabetical position — a stable,
reproducible mapping (a real tokenizer keeps this same string ↔ id contract; a *mismatch* between the
tokenizer that built the vocab and the one used at inference is a classic way to get garbage vectors).

Click **Check** to verify your vocabulary: contiguous ids, sorted order, and the expected size.

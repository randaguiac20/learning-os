# Step 2 — Tokenize by hand

Before any library, *feel* what tokenization is. The naive scheme: **normalize** (lowercase, strip
punctuation to spaces), then **split** on whitespace into **tokens** — the atomic units a model
consumes.

```bash
cd ~/nlp-lab
```{{exec}}

```bash
python3 - <<'PY'
text = "I LOVE this movie -- it was FANTASTIC!"
# normalize: lowercase, and replace any non-alphanumeric char with a space
norm = "".join(c.lower() if (c.isalnum() or c.isspace()) else " " for c in text)
tokens = norm.split()
print("raw   :", text)
print("norm  :", norm)
print("tokens:", tokens)
print("count :", len(tokens))
PY
```{{exec}}

Notice what "split on spaces" costs you: every distinct surface form is its own token, so the
**vocabulary** explodes, and a word you've never seen has *no* token at all. That is exactly why real
models use **subword** tokenization (BPE / WordPiece) — it splits rare words into reusable pieces
(`unhappiness → un · happi · ness`) so even an unseen word still gets tokens.

You just ran the first stage of the pipeline by hand: **text → tokens.** Next you turn a whole corpus
into a numbered vocabulary.

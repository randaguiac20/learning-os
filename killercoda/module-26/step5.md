# Step 5 — A toy tokenizer, and the API path

Models don't read words or letters — they read **tokens**, subword pieces earned by frequency. A toy
whitespace tokenizer shows the core idea: split, build a vocab, assign ids, and reuse ids for repeats.

Create `tokenize.py`:

```bash
cat > ~/ai-foundations/tokenize.py <<'PY'
text = "the cat sat on the mat and the cat ran"
tokens = text.split()                              # naive whitespace tokenizer
vocab = {}
for t in tokens:
    if t not in vocab:
        vocab[t] = len(vocab)                      # earn an id on first sight
ids = [vocab[t] for t in tokens]
print("vocab:", vocab)
print("ids:  ", ids)
print("tokens:", len(tokens), " vocab size:", len(vocab))
PY
```{{exec}}

Run it:

```bash
cd ~/ai-foundations && python3 tokenize.py
```{{exec}}

`the` appears three times but claims only one vocab slot — that reuse is what real BPE industrialises on
subword *pieces*. It's also why context is a **budget**: an unseen word costs a fresh id (or several
pieces), so a rarer language shatters into more tokens than English.

## Run locally with your key — the real LLM

Everything above runs anywhere with no account. To watch the **same mechanism** at scale, call the Claude
API from your *own* machine with your *own* key (never in code or shell history — decrypt at use, per Module
24). This is illustrative — do **not** run it here on Killercoda:

```python
# pip install anthropic ; export ANTHROPIC_API_KEY=...  (from your sops estate)
import anthropic
client = anthropic.Anthropic()                 # reads ANTHROPIC_API_KEY
resp = client.messages.create(
    model="claude-opus-5",
    max_tokens=200,
    messages=[{"role": "user", "content": "In one sentence: what is a token?"}],
)
print(resp.content[0].text)
print("input tokens:", resp.usage.input_tokens)   # the same tokens you just counted
```

Same loop as your `gd.py`, only with billions more dials and text pieces instead of numbers — and
`usage.input_tokens` is exactly the count your toy tokenizer was estimating. You navigated the whole
pipeline: vectors, similarity, a loss made to fall, and text turned into ids. That's Module 26, hands-on.

# Done — you walked the NLP pipeline

In ~30 minutes you:

- **Tokenized** text by hand — normalize, split, and turn a corpus into a **vocabulary** with a stable
  **token → id** map (`vocab.json`).
- Built a **TF-IDF** vectorizer over a small inline labeled corpus and trained a `LogisticRegression`
  classifier — the same tokenizer/vocab reused for training and inference.
- **Evaluated on held-out sentences**, reporting **accuracy and macro-F1** (`metrics.json`) — and saw
  why F1, not accuracy, is the honest metric on imbalanced text.
- Computed **cosine similarity** between documents by hand (M30's normalized dot product) and read the
  classifier's **most informative words**.

That is the pipeline every NLP system runs, from a spam filter to an LLM: **text → tokenize → vectorize
→ model → evaluate.** The transformer swaps TF-IDF's bag-of-words for learned embeddings and
self-attention — but the shape is the one you just built.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
Push further with the Solo Lab challenges — prove accuracy lies on imbalanced text, do the analogy
arithmetic, break it with a tokenizer mismatch, and sketch the RAG guardrail.

> The one-sentence takeaway: **meaning becomes geometry, attention is a weighted average (O(n²)), and
> fluent is not correct — so the metric must match the task.**

# Step 4 — TF-IDF, train, and evaluate

Now the real thing: turn each sentence into a **TF-IDF** (Term Frequency–Inverse Document Frequency)
vector — which weights each word by how *informative* it is (frequent here, rare across the corpus) —
train a `LogisticRegression` classifier, and evaluate it on the **held-out** sentences it never saw.

```bash
cat > ~/nlp-lab/classify.py <<'PY'
import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, f1_score
from corpus import TRAIN, TEST

train_texts = [t for t, _ in TRAIN]
train_y     = [y for _, y in TRAIN]
test_texts  = [t for t, _ in TEST]
test_y      = [y for _, y in TEST]

# fit TF-IDF on TRAIN only, then reuse the SAME vectorizer on the held-out set
vec = TfidfVectorizer()
Xtr = vec.fit_transform(train_texts)
clf = LogisticRegression(max_iter=1000)
clf.fit(Xtr, train_y)

Xte  = vec.transform(test_texts)      # transform, NOT fit — same tokenizer/vocab as training
pred = clf.predict(Xte)

acc = accuracy_score(test_y, pred)
f1  = f1_score(test_y, pred, average="macro")

with open("metrics.json", "w") as f:
    json.dump({"accuracy": acc, "f1_macro": f1, "n_test": len(test_y)}, f, indent=2)

print("held-out predictions:", list(pred))
print("held-out true labels:", test_y)
print(f"accuracy: {acc:.3f}   macro-F1: {f1:.3f}   n_test: {len(test_y)}")
PY
```{{exec}}

Train and evaluate — this writes `metrics.json`:

```bash
cd ~/nlp-lab && python3 classify.py
```{{exec}}

```bash
cat metrics.json
```{{exec}}

The lab reports **macro-F1** alongside accuracy on purpose. On this tiny balanced set they agree — but
on real, *imbalanced* text, accuracy can look high while the model misses the minority class entirely,
and **F1** is the number that exposes it (M27). Choosing the metric that matches the task is the
discipline.

Click **Check** to verify the held-out accuracy cleared the bar and `metrics.json` was written.

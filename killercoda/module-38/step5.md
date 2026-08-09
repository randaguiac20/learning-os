# Step 5 — Cosine similarity and informative words

Two more pipeline reflexes. First, **cosine similarity** (M30) — the normalized dot product of two
documents' TF-IDF vectors. Near `1` means "same direction / same topic," near `0` means unrelated.
Compute it by hand with numpy:

```bash
cat > ~/nlp-lab/similarity.py <<'PY'
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from corpus import TRAIN

vec = TfidfVectorizer().fit([t for t, _ in TRAIN])

doc_a = "a wonderful and fantastic film truly great"
doc_b = "an awful and terrible movie truly bad"
doc_c = "a wonderful and great film i loved it"

A, B, C = vec.transform([doc_a, doc_b, doc_c]).toarray()

def cosine(u, v):                     # normalized dot product — M30
    return float(u @ v / (np.linalg.norm(u) * np.linalg.norm(v)))

print("A vs B (opposite sentiment):", round(cosine(A, B), 3))
print("A vs C (same sentiment)    :", round(cosine(A, C), 3))
PY
```{{exec}}

```bash
cd ~/nlp-lab && python3 similarity.py
```{{exec}}

`A` and `C` (both positive) should score clearly higher than `A` and `B` (opposite sentiment) — meaning
as geometry, made real. Now inspect the classifier's **most informative words** — the features whose
weights pushed hardest toward each class:

```bash
cat > ~/nlp-lab/informative.py <<'PY'
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from corpus import TRAIN

texts = [t for t, _ in TRAIN]
y     = [lab for _, lab in TRAIN]

vec = TfidfVectorizer()
X   = vec.fit_transform(texts)
clf = LogisticRegression(max_iter=1000).fit(X, y)

names = np.array(vec.get_feature_names_out())
coef  = clf.coef_[0]                  # + pushes toward positive, - toward negative
order = np.argsort(coef)

print("most POSITIVE words:", list(names[order[-8:]][::-1]))
print("most NEGATIVE words:", list(names[order[:8]]))
PY
```{{exec}}

```bash
python3 informative.py
```{{exec}}

The top positive and negative words should read like the sentiment they signal (`wonderful`,
`fantastic` … vs `awful`, `terrible` …). That is the model made legible — it learned which words carry
the label. You walked the whole pipeline: **text → tokenize → vectorize → model → evaluate.**

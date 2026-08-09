# Step 1 — Set up the bench

The bench is Python with **scikit-learn** (it gives you `TfidfVectorizer` and `LogisticRegression`) and
**numpy** (the vector math). Install them — CPU only, no model downloads:

```bash
apt-get update -y && apt-get install -y python3-pip
```{{exec}}

```bash
pip install scikit-learn numpy 2>/dev/null || pip install --break-system-packages scikit-learn numpy
```{{exec}}

Confirm the imports work:

```bash
python3 -c "import sklearn, numpy; print('sklearn', sklearn.__version__, '| numpy', numpy.__version__)"
```{{exec}}

Make the sandbox directory and move in — all work happens here:

```bash
mkdir -p ~/nlp-lab && cd ~/nlp-lab
```{{exec}}

Now write the **inline labeled corpus** — a dozen sentiment sentences (label `1` = positive,
`0` = negative) plus four **held-out** sentences the model will be tested on. This is your whole
dataset; there is nothing to download.

```bash
cat > ~/nlp-lab/corpus.py <<'PY'
# A small, inline, labeled sentiment corpus — no downloads.
# label 1 = positive, 0 = negative
TRAIN = [
    ("i love this movie it was fantastic and wonderful", 1),
    ("an excellent film truly great and enjoyable", 1),
    ("what a wonderful and delightful experience i loved it", 1),
    ("the acting was brilliant and the story was great", 1),
    ("a fantastic and amazing performance highly recommend", 1),
    ("i really enjoyed this it was a great and happy film", 1),
    ("i hate this movie it was terrible and boring", 0),
    ("an awful film truly bad and disappointing", 0),
    ("what a horrible and dreadful experience i hated it", 0),
    ("the acting was poor and the story was terrible", 0),
    ("a boring and awful performance do not recommend", 0),
    ("i really disliked this it was a bad and sad film", 0),
]
# Held-out sentences the model never trains on — the honest test set.
TEST = [
    ("a wonderful and great film i loved it", 1),
    ("truly fantastic and enjoyable highly recommend", 1),
    ("a terrible and boring movie i hated it", 0),
    ("truly awful and disappointing do not recommend", 0),
]
PY
```{{exec}}

```bash
python3 -c "from corpus import TRAIN, TEST; print(len(TRAIN), 'train +', len(TEST), 'held-out sentences')"
```{{exec}}

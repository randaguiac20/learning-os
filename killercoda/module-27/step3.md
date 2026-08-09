# Step 3 — Train and evaluate

Train a **logistic regression** — rung 1 of the classical ladder, the honest first model — then measure it
on the held-out test set and read the **confusion matrix**. The script also proves the split was honest:
it checks that no row appears in both train and test.

```bash
cd ~/ml-lab
```{{exec}}

```bash
cat > train.py <<'EOF'
import json
import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix

X, y = load_digits(return_X_y=True)
idx = np.arange(len(y))
Xtr, Xte, ytr, yte, itr, ite = train_test_split(
    X, y, idx, test_size=0.25, random_state=42, stratify=y)

clf = LogisticRegression(max_iter=5000)
clf.fit(Xtr, ytr)                                   # fit on TRAIN only

train_acc = accuracy_score(ytr, clf.predict(Xtr))
test_acc  = accuracy_score(yte, clf.predict(Xte))   # the honest number
cm = confusion_matrix(yte, clf.predict(Xte))
overlap = len(set(itr.tolist()) & set(ite.tolist()))    # honesty check: must be 0

metrics = {
    "model": "logistic_regression",
    "n_train": int(len(itr)), "n_test": int(len(ite)),
    "train_accuracy": round(float(train_acc), 4),
    "test_accuracy":  round(float(test_acc), 4),
    "train_test_overlap": int(overlap),
}
with open("metrics.json", "w") as f:
    json.dump(metrics, f, indent=2)
print(json.dumps(metrics, indent=2))
print("Confusion matrix (rows = true, cols = predicted):")
print(cm)
EOF
```{{exec}}

```bash
python3 train.py
```{{exec}}

Test accuracy lands around **0.96**, and `train_test_overlap` is **0** — the split was honest, no row
leaked from train into test. Read the confusion matrix: the strong diagonal is correct predictions;
off-diagonal cells are the specific mistakes (which digit got confused for which).

Click **Check** to verify `metrics.json` shows honest test accuracy above the bar.

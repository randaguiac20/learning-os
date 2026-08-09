# Step 5 — Baseline and cross-validation

Two habits that separate engineers from notebook artists. First the **baseline law**: how well does a
*dumb* model do? Your model's worth is the *difference* from that floor, not the absolute number. Then
**cross-validation** for a stable estimate under the split you already made.

```bash
cd ~/ml-lab
```{{exec}}

```bash
cat > baseline_cv.py <<'EOF'
import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.dummy import DummyClassifier
from sklearn.linear_model import LogisticRegression

X, y = load_digits(return_X_y=True)
Xtr, Xte, ytr, yte = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y)

# The baseline: always predict the majority class. Beat this or you have nothing.
dummy = DummyClassifier(strategy="most_frequent").fit(Xtr, ytr)
print("baseline (always the majority class):", round(dummy.score(Xte, yte), 4))

# 5-fold CV on the TRAINING data only -> a stable estimate for CHOICES.
scores = cross_val_score(LogisticRegression(max_iter=5000), Xtr, ytr, cv=5)
print("logistic 5-fold CV accuracy:", np.round(scores, 4))
print("CV mean +/- std:", round(scores.mean(), 4), "+/-", round(scores.std(), 4))
print("\nYour model's worth is the DIFFERENCE from the ~0.10 baseline,")
print("not the absolute number. And CV never replaces the test set -")
print("you TUNED on CV, so its number carries your optimism.")
EOF
```{{exec}}

```bash
python3 baseline_cv.py
```{{exec}}

The majority-class baseline scores about **0.10** (ten roughly-equal classes). Your ~0.96 model is worth
the *gap* over that floor — that is the baseline law made concrete. The CV scores cluster tightly, so the
model's quality is a stable finding, not a lucky split.

You ran the whole discipline on a CPU: honest split, a trained model, a confusion matrix, overfitting
caused and cured, a baseline beaten with cross-validated evidence. That is Module 27, hands-on.

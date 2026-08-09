# Step 4 — Meet the dragon: overfit, then cure it

Now cause **overfitting** on purpose. An **unbounded decision tree** keeps splitting until it *memorizes*
the training set — train accuracy hits 100%, but test accuracy sags. That gap between train and test IS
the dragon. Then cap the tree's depth (a form of **regularization**) and watch the gap shrink.

```bash
cd ~/ml-lab
```{{exec}}

```bash
cat > overfit.py <<'EOF'
import json
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score

X, y = load_digits(return_X_y=True)
Xtr, Xte, ytr, yte = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y)

# OVERFIT: no depth limit -> the tree memorizes noise (high variance).
deep = DecisionTreeClassifier(random_state=0).fit(Xtr, ytr)
d_tr = accuracy_score(ytr, deep.predict(Xtr))
d_te = accuracy_score(yte, deep.predict(Xte))

# CURE: cap capacity -> deliberately-chosen bias tames the variance.
fixed = DecisionTreeClassifier(max_depth=8, random_state=0).fit(Xtr, ytr)
f_tr = accuracy_score(ytr, fixed.predict(Xtr))
f_te = accuracy_score(yte, fixed.predict(Xte))

res = {
    "overfit_train_accuracy": round(float(d_tr), 4),
    "overfit_test_accuracy":  round(float(d_te), 4),
    "overfit_gap":            round(float(d_tr - d_te), 4),
    "fixed_train_accuracy":   round(float(f_tr), 4),
    "fixed_test_accuracy":    round(float(f_te), 4),
    "fixed_gap":              round(float(f_tr - f_te), 4),
}
with open("overfit.json", "w") as f:
    json.dump(res, f, indent=2)
print(json.dumps(res, indent=2))
print("\nThe overfit tree scored ~1.0 on train but far less on test:")
print("that gap IS the dragon. Capping depth shrank it.")
EOF
```{{exec}}

```bash
python3 overfit.py
```{{exec}}

The unbounded tree shows train **~1.0** with a large `overfit_gap` (about 0.18); the depth-capped tree
gives up a little train accuracy but its `fixed_gap` is smaller (about 0.12). You just watched the
bias-variance **U-curve** happen: regularization traded a sliver of flexibility for honesty.

Click **Check** to verify `overfit.json` shows a large overfit gap that the cure reduced.

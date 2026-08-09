# Step 2 — Load data and split honestly

Load the **digits** dataset: 1797 hand-written digits, each described by **64 pixel features**, each with
a **label** from `0` to `9`. Features are the inputs the model reads; the label is the answer you want back.

The most important habit in this whole module: **split the data FIRST**, before you explore relationships.
Looking at the test rows before you split leaks your choices into them.

```bash
cd ~/ml-lab
```{{exec}}

```bash
cat > explore.py <<'EOF'
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split

X, y = load_digits(return_X_y=True)          # X = features, y = labels
print("features X:", X.shape, "- labels y:", y.shape)
print("one example is", X.shape[1], "pixel values; its label is a digit 0-9")

# Split FIRST. test_size=0.25 seals a quarter away; stratify=y keeps the
# class balance in every split; random_state makes it reproducible.
Xtr, Xte, ytr, yte = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y)
print("train rows:", len(ytr), "- test rows:", len(yte))
EOF
```{{exec}}

```bash
python3 explore.py
```{{exec}}

You just sealed 25% of the data away as a **test set**. The model will not see those rows until the single
final measurement in Step 3 — that is the *split contract*, enforced in one line of code.

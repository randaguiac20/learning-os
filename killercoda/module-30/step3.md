# Step 3 — Eigenvalues: confirm `A·v = λ·v`

An **eigenvector** is a direction the transformation **only stretches**, never rotates; the **eigenvalue**
`λ` (lambda) is the stretch factor: **`A·v = λ·v`**. This is the module's payload — PageRank, PCA, and
stability are all "find the special directions."

Write a script that computes the eigenpairs, checks `A·v == λ·v` **within a tolerance** for each, and saves
the result to a file the verifier will read:

```bash
cd ~/math-lab
```{{exec}}

```bash
cat > eig_check.py <<'EOF'
import json
import numpy as np

# A symmetric matrix — real eigenvalues, and a clean stretch along its eigenvectors.
A = np.array([[2.0, 1.0],
              [1.0, 2.0]])

vals, vecs = np.linalg.eig(A)

max_error = 0.0
for i in range(len(vals)):
    lam = vals[i]
    v = vecs[:, i]
    lhs = A @ v            # A · v
    rhs = lam * v          # λ · v
    err = float(np.max(np.abs(lhs - rhs)))    # should be ~0
    max_error = max(max_error, err)
    print(f"λ = {lam:.4f}   max|A·v − λ·v| = {err:.2e}")

result = {
    "check": "A·v == λ·v",
    "lambdas": sorted(round(float(x), 6) for x in vals),
    "max_error": max_error,
    "all_verified": bool(max_error < 1e-6),
}
with open("eig_result.json", "w") as f:
    json.dump(result, f, indent=2)
print(json.dumps(result, indent=2))
EOF
```{{exec}}

```bash
python3 eig_check.py
```{{exec}}

Every eigenpair satisfies `A·v = λ·v` to machine precision (`max_error` far below `1e-6`), and
`all_verified` is **true**. For this matrix the eigenvalues are **1** and **3** — the two directions it
purely stretches.

> Try it: swap `A` for a **rotation** `[[0,-1],[1,0]]` and re-run — `eig` returns **complex** eigenvalues.
> Not a bug: a rotation turns *every* direction, so it has **no real invariant one**.

Click **Check** to verify `eig_result.json` shows the eigenvalue check passed within tolerance.

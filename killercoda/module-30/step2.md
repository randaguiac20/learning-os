# Step 2 — Vectors and matrices: dot product, transform, `A·A⁻¹ = I`

A **vector** is a point / a direction / a list of numbers. The **dot product** `a·b = Σ aᵢbᵢ` measures
**alignment** — large when aligned, **zero when perpendicular**. Predict each result before you run it:

```bash
cd ~/math-lab
```{{exec}}

```bash
python3 - <<'EOF'
import numpy as np
a = np.array([2.0, 1.0]); b = np.array([3.0, 4.0]); c = np.array([-1.0, 2.0])
print("a·b =", np.dot(a, b))          # predict: 2*3 + 1*4 = 10
print("a·c =", np.dot(a, c))          # 2*-1 + 1*2 = 0  -> perpendicular!
def cosine(u, v): return np.dot(u, v) / (np.linalg.norm(u) * np.linalg.norm(v))
print("cos(a,b) =", round(float(cosine(a, b)), 4))   # aligned -> near 1
print("cos(a,c) =", round(float(cosine(a, c)), 4))   # perpendicular -> 0
EOF
```{{exec}}

`a·c = 0` means **perpendicular** — the dot product caught it. **Cosine** strips out length and leaves pure
direction: this is M26's embedding similarity, named.

Now a **matrix as a transformation**. `A·x` applies the transform to `x`; the matrix's **columns are where
the basis vectors land**. Matrix multiplication is **composition** — so `AB ≠ BA` — and the **inverse**
undoes the verb: `A·A⁻¹ = I` (the identity):

```bash
python3 - <<'EOF'
import numpy as np
A = np.array([[0.0, -1.0], [1.0, 0.0]])          # a 90-degree rotation
print("A @ [1,0] =", A @ np.array([1.0, 0.0]))   # basis vector (1,0) lands on (0,1)
S = np.array([[1.0, 1.0], [0.0, 1.0]])           # a shear
print("AB == BA ?", np.allclose(A @ S, S @ A))   # False -> order matters
print("A @ inv(A) =\n", np.round(A @ np.linalg.inv(A), 6))   # the identity I
EOF
```{{exec}}

The rotation sends `(1,0)` to `(0,1)`; `AB ≠ BA` because composition order matters; and `A·A⁻¹ = I` proves
the inverse undoes the transformation. **A matrix is a verb.**

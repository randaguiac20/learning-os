# Done — the math is readable now

In ~30 minutes, on a plain CPU, you:

- Read the **dot product as similarity** and saw cosine strip out length — M26's embeddings, named.
- Treated a **matrix as a transformation** (columns are where the basis vectors land), showed `AB ≠ BA`,
  and proved the inverse undoes it with `A·A⁻¹ = I`.
- Confirmed **`A·v = λ·v`** for every eigenpair within tolerance — the eigenvector is the direction only
  stretched (and saw why a rotation's eigenvalues are complex).
- Built a graph's **adjacency matrix** and used **matrix powers** to count walks and find reachable nodes —
  the discrete↔linear bridge in code.
- Used **modular arithmetic** (crypto's and hashing's engine) and the **pigeonhole principle** to *prove*
  hash collisions are inevitable.

Every claim was **machine-checked** — the gradient-check habit (M26) generalized: never trust a hand-calc you
didn't verify.

**Back on the lesson page:** do the *Solo Lab* (PCA from scratch, SVD compression, big-O by counting), the
*Self-Check*, and tick the *Mastery checklist*. When every box is honestly true, Module 31 (Calculus,
Probability & Statistics — the continuous half) becomes current.

> The one-sentence takeaway: **discrete math and linear algebra are the two languages the back half of the
> curriculum was written in — and you can now READ them, which is the line between using AI systems and
> engineering them.**

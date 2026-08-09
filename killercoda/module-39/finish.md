# Done — you saw how a machine sees

In ~30 minutes, on a plain CPU with no downloads, you:

- Built a **synthetic image** and read it as a **tensor** — shape `(H × W × C)`, three RGB numbers per
  pixel (M30), then a flat grayscale grid.
- Implemented a **convolution BY HAND** — slid a Sobel **kernel** across the grid and watched the edges
  light up in the **feature map**, high on the border and ~0 in the flat regions. One shared filter found
  the edges *everywhere* (**translation invariance + parameter sharing** — why CNNs beat fully-connected
  nets on images).
- Applied **blur and sharpen** kernels (same machinery, opposite effects) and **max-pooled** to
  *downsample* the image `64×64 → 32×32`.
- **Thresholded a mask** — a per-pixel object/background label, the shape of a **segmentation** output.

Every claim was **machine-checked** — the same "verify, don't trust the eye" discipline that runs through
the whole curriculum (M26's gradient-check, M27's metrics): a mask that *looks* right is scored with
**IoU**, not by eye.

**Back on the lesson page:** do the *Solo Lab* (prove translation invariance, average-vs-max pool, the
identity-kernel self-check, IoU by hand, and the "99% accurate — ship it?" judgment), the *Self-Check*,
and tick the *Mastery checklist*. When every box is honestly true, you've closed **Module 39 — the
curriculum's final module.**

> The one-sentence takeaway: **convolution and the learned feature hierarchy let machines *see*, transfer
> learning builds a real model from little data, and the metric-and-fairness discipline — confident ≠
> correct, and fair for whom — is the closing lesson the whole journey was built to earn.**

# Step 4 — Blur, sharpen, and pool (downsample)

**Blur** and **sharpen** are just two more kernels — same convolution machinery, opposite effects. Then
**pooling** *downsamples* the image: max-pooling keeps the largest value in each block, halving height
and width (less compute, a wider view for deeper layers).

```bash
cd ~/vision-lab
```{{exec}}

```bash
cat > pool.py <<'PY'
import json
import numpy as np
from convolve import convolve          # reuse the hand convolution from step 3

gray = np.load("gray.npy")

blur    = np.ones((3, 3)) / 9.0                                     # box blur — averages neighbors
sharpen = np.array([[0, -1, 0], [-1, 5, -1], [0, -1, 0]], float)   # emphasizes the center
_ = convolve(gray, blur)                                            # apply both (opposite effects)
_ = convolve(gray, sharpen)

def max_pool(im, size=2):
    """Downsample: keep the max of each size x size block -> half the height and width."""
    h, w = im.shape
    oh, ow = h // size, w // size
    out = np.zeros((oh, ow))
    for r in range(oh):
        for c in range(ow):
            out[r, c] = im[r*size:(r+1)*size, c*size:(c+1)*size].max()
    return out

pooled = max_pool(gray, 2)
result = {
    "input_shape": list(gray.shape),        # [64, 64]
    "pooled_shape": list(pooled.shape),     # [32, 32] — halved
    "pool_size": 2,
    "blur_applied": True,
    "sharpen_applied": True,
}
with open("pool_result.json", "w") as f:
    json.dump(result, f, indent=2)
print(json.dumps(result, indent=2))
PY
```{{exec}}

```bash
python3 pool.py
```{{exec}}

Read the result: the input was `[64, 64]`, the pooled image is `[32, 32]` — exactly **half** in each
dimension. That size reduction is why a CNN can stack many layers cheaply: each pool shrinks the grid,
so deeper convolutions cover a wider area with the same tiny filter.

> Try it: change `max_pool(gray, 2)` to `max_pool(gray, 4)` — the output becomes `[16, 16]`. Bigger
> pool, smaller image, more information thrown away.

Click **Check** to verify the pooled image is exactly half the input's height and width.

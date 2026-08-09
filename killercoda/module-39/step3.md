# Step 3 — Convolution by hand — Sobel edges

The module's keystone mechanic. A **kernel/filter** is a small matrix slid over the image; a
**convolution** computes a weighted sum at each position, producing a **feature map**. Slide an
edge-detecting **Sobel** kernel and the edges of the square light up.

```bash
cd ~/vision-lab
```{{exec}}

```bash
cat > convolve.py <<'PY'
import json
import numpy as np

gray = np.load("gray.npy")               # (64,64) grayscale from step 2

# A kernel/filter is a small matrix slid over the image. Sobel detects edges:
Kx = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]], dtype=np.float64)   # vertical edges
Ky = np.array([[-1, -2, -1], [0, 0, 0], [1, 2, 1]], dtype=np.float64)   # horizontal edges

def convolve(im, k):
    """Slide k over im, weighted-sum at each position -> a feature map (same size, zero-padded)."""
    kh, kw = k.shape
    pad = kh // 2
    padded = np.pad(im, pad, mode="constant")
    out = np.zeros_like(im)
    for r in range(im.shape[0]):
        for c in range(im.shape[1]):
            out[r, c] = np.sum(padded[r:r+kh, c:c+kw] * k)   # THE convolution
    return out

if __name__ == "__main__":
    gx, gy = convolve(gray, Kx), convolve(gray, Ky)
    mag = np.sqrt(gx**2 + gy**2)         # edge magnitude — high on the square's border

    from PIL import Image
    Image.fromarray((mag / mag.max() * 255).astype("uint8")).save("edges.png")

    result = {
        "shape": list(mag.shape),
        "max_edge": float(mag.max()),
        "interior_mean": float(mag[24:40, 24:40].mean()),    # flat inside the square -> ~0
        "background_mean": float(mag[0:12, 0:12].mean()),    # flat background -> ~0
        "edge_pixel_fraction": float((mag > 100).mean()),    # edges are SPARSE (a border)
        "edges_png_exists": True,
    }
    with open("edge_result.json", "w") as f:
        json.dump(result, f, indent=2)
    print(json.dumps(result, indent=2))
PY
```{{exec}}

```bash
python3 convolve.py
```{{exec}}

Read the result: `max_edge` is large (the border is a strong edge), while `interior_mean` and
`background_mean` are ~0 (flat regions have no edge), and `edge_pixel_fraction` is small — edges are a
**sparse border**, not the whole image. One shared 9-number filter (parameter sharing) found the edges
**everywhere they appear** (translation invariance) — the whole reason a CNN beats a fully-connected net
on images.

> Try it: swap `Kx` for a **blur** `np.ones((3,3))/9` and re-run — the edges *soften* instead of
> sharpening. Same machinery, different kernel.

Click **Check** to verify the edges landed on the border and not the flat regions.

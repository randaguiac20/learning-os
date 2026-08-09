# Step 5 — Threshold to a binary mask (toy segmentation)

Classification asks *what is it?* (one label). **Segmentation** asks *which pixels are the object?* — a
**per-pixel** label. A threshold gives a toy version: every pixel becomes **object (1)** or **background
(0)**.

```bash
cd ~/vision-lab
```{{exec}}

```bash
cat > segment.py <<'PY'
import numpy as np
from PIL import Image

gray = np.load("gray.npy")
mask = (gray > 127).astype(np.uint8)          # 1 where the object is, 0 for background
Image.fromarray(mask * 255).save("mask.png")

print("mask shape:", mask.shape)
print("foreground pixels:", int(mask.sum()), "of", mask.size)      # 1024 of 4096 = the square
print("foreground fraction:", round(float(mask.mean()), 3))
PY
```{{exec}}

```bash
python3 segment.py
```{{exec}}

The mask separates the square (`1`) from the background (`0`) — **1024 of 4096** pixels are foreground,
exactly the 32×32 square. That per-pixel labeling is the *shape* of a segmentation output.

```bash
ls -l mask.png edges.png square_rgb.png
```{{exec}}

This toy mask is exact only because the image is synthetic. A real segmenter (**U-Net** / **Mask
R-CNN**) *learns* the mask from data, and you would score it with **IoU** (Intersection over Union), not
by eye — because a mask that "looks right" can still overlap the truth poorly. *Match the metric to the
task* (M27): "looks right" is not measured right.

> You built the whole front of the vision pipeline by hand: an image as a tensor -> convolution ->
> feature map -> pooling -> a per-pixel mask. That is what a CNN does inside, at scale.

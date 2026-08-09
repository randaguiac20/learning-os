# Step 2 — A synthetic image as a tensor

To a computer an image is not a picture — it's a **tensor** of numbers (M30). Build one so nothing needs
downloading: a black background with a red square. Then look at its shape and channels.

```bash
cd ~/vision-lab
```{{exec}}

```bash
cat > make_image.py <<'PY'
import numpy as np
from PIL import Image

# RGB image: black background, a white square — shape H × W × C
rgb = np.zeros((64, 64, 3), dtype=np.uint8)
rgb[16:48, 16:48] = [255, 255, 255]               # white square (all three channels high)
print("RGB shape:", rgb.shape, "| dtype:", rgb.dtype)      # (64, 64, 3)
print("a background pixel:", rgb[0, 0].tolist())           # [0, 0, 0]
print("a square pixel   :", rgb[32, 32].tolist())          # [255, 255, 255] — three numbers
Image.fromarray(rgb).save("square_rgb.png")

# Convert to grayscale (one number per pixel) for the convolution work
gray = np.array(Image.fromarray(rgb).convert("L"), dtype=np.float64)
print("grayscale shape:", gray.shape, "| min", gray.min(), "max", gray.max())
np.save("gray.npy", gray)
print("saved square_rgb.png and gray.npy")
PY
```{{exec}}

```bash
python3 make_image.py
```{{exec}}

Read the output: the image is a tensor of shape `(64, 64, 3)` — **height × width × channels**. Each
pixel is **three numbers** (Red, Green, Blue). Grayscale drops the channel axis to one number per pixel
— the flat grid the kernel will slide over in the next step.

```bash
ls -l gray.npy square_rgb.png
```{{exec}}

> Try it: change the square to a mid-gray `[128, 128, 128]` and re-run — the pixel *numbers* drop, but
> the shape `(64, 64, 3)` does not. Shape is *structure*; the numbers are *content*. (Re-run the shipped
> version afterward so the later steps use the bright square.)

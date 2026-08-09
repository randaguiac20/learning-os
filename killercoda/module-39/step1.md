# Step 1 — Set up the bench (numpy + pillow)

Install `pip`, then **numpy** (holds the image as an array) and **pillow** (PIL — saves an array to a
PNG). That is the whole bench — no GPU, no model download.

```bash
apt-get update -qq && apt-get install -y python3-pip
```{{exec}}

```bash
pip install numpy pillow 2>/dev/null || pip install --break-system-packages numpy pillow
```{{exec}}

Make a working directory — everything in this lab lives here:

```bash
mkdir -p ~/vision-lab && cd ~/vision-lab
```{{exec}}

Confirm both installed and see the versions:

```bash
python3 -c "import numpy, PIL; print('numpy', numpy.__version__, '| pillow', PIL.__version__)"
```{{exec}}

You now have a full computer-vision bench on a plain CPU. The convolution you'll write by hand below is
exactly what a GPU does inside a CNN (M22/M28) — just smaller, and in seconds.

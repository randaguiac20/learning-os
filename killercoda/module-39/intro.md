# Computer Vision — hands-on

You have a real Linux machine on the right and a plain **CPU** — which is all you need. Every idea in
this lab runs in **milliseconds** with nothing but **numpy** and **pillow**: no GPU, no downloads. You'll
make your own image so there's nothing to fetch.

In the next few minutes you'll **see how a machine sees** — the ritual is **predict → run → look** (say
what should happen before you run it):

- **An image is a tensor** — a grid of pixels, shape **H × W × C** (height × width × channels, M30).
- **Convolution BY HAND** — slide a small edge-detecting **kernel** across the image and watch the edges
  light up in the **feature map** (translation invariance + parameter sharing — why CNNs suit images).
- **Blur, sharpen, and pool** — two more kernels, then **max-pooling** to *downsample* the image smaller.
- **Threshold to a mask** — split pixels into object vs background: the shape of a **segmentation**
  output.

> Tip: **type every command yourself** — and predict each result before you run it. Building convolution
> by hand *before* reaching for a library is the module's law (M26's build-it-yourself discipline): you
> understand what a CNN does only once you've slid a filter across a grid with your own code.

Click **START** to begin.

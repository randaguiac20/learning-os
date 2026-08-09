#!/bin/bash
# Killercoda step verifier: pass (exit 0) when convolve.py wrote edge_result.json + edges.png AND the
# hand convolution put strong edges on the square's border while the flat interior/background stayed ~0.
lab="$HOME/vision-lab"
rf="$lab/edge_result.json"
[ -f "$rf" ] || { echo "edge_result.json not found in ~/vision-lab — run: python3 convolve.py"; exit 1; }
[ -f "$lab/edges.png" ] || { echo "edges.png not found — run: python3 convolve.py"; exit 1; }

python3 - "$rf" <<'PY'
import json, sys
try:
    r = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse edge_result.json:", e); sys.exit(1)

shape   = r.get("shape")
mx      = r.get("max_edge")
interior= r.get("interior_mean")
bg      = r.get("background_mean")
frac    = r.get("edge_pixel_fraction")

for k, v in [("max_edge", mx), ("interior_mean", interior),
             ("background_mean", bg), ("edge_pixel_fraction", frac)]:
    if v is None:
        print(f"edge_result.json is missing '{k}' — re-run the shipped convolve.py."); sys.exit(1)

if shape != [64, 64]:
    print(f"feature map shape {shape}, expected [64, 64] — restore the shipped convolve.py."); sys.exit(1)

# A clean 0->255 step through the Sobel kernel yields a magnitude in the hundreds+.
if mx < 300:
    print(f"max_edge={mx:.1f} is too low — the edge kernel didn't fire. Check the convolution."); sys.exit(1)

# Flat interior and background must be ~0 (no edge where the image doesn't change).
if interior > 1.0 or bg > 1.0:
    print(f"interior_mean={interior:.3f}, background_mean={bg:.3f} — flat regions should be ~0. "
          "Edges leaked into flat areas; check padding/indexing."); sys.exit(1)

# Edges are a sparse border, not the whole image (but there ARE some).
if not (0.0 < frac < 0.30):
    print(f"edge_pixel_fraction={frac:.3f} — expected a small sparse fraction (0 < f < 0.30). "
          "Restore the shipped convolve.py."); sys.exit(1)

print(f"Verified: max_edge={mx:.0f} on the border, interior/background ~0 ({interior:.2f}/{bg:.2f}), "
      f"edges sparse ({frac*100:.1f}% of pixels). Your hand convolution found the edges everywhere they appear.")
PY

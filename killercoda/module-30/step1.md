# Step 1 — Set up the numpy bench

Install `pip`, then **numpy** — the entire lab bench. numpy ships its own linear-algebra routines
(`np.linalg`), so nothing else is needed.

```bash
apt-get update -qq && apt-get install -y python3-pip
```{{exec}}

```bash
pip install numpy 2>/dev/null || pip install --break-system-packages numpy
```{{exec}}

Make a working directory — everything in this lab lives here:

```bash
mkdir -p ~/math-lab && cd ~/math-lab
```{{exec}}

Confirm the install worked and see the version:

```bash
python3 -c "import numpy; print('numpy', numpy.__version__)"
```{{exec}}

You now have a full linear-algebra toolbox on a plain CPU. The math below is identical to what a GPU does
(M22) — it's just smaller and runs in seconds.

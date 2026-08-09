# Step 1 — Set up the bench

Every idea in this module fits in plain numpy on a CPU. First, pip and numpy:

```bash
apt-get update -qq && apt-get install -y python3-pip
```{{exec}}

```bash
pip install numpy
```{{exec}}

Make a throwaway project and move in — all your scripts live here:

```bash
mkdir -p ~/ai-foundations && cd ~/ai-foundations
```{{exec}}

Confirm numpy imports:

```bash
python3 -c "import numpy; print('numpy', numpy.__version__)"
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- What is the difference between a **library** (numpy) and a **model**? (One is code you call; the other is
  numbers you *fit*.)
- Nothing here needs a GPU or an API key. Training and inference are just arithmetic — the scale is what
  eventually needs the silicon of Module 22.

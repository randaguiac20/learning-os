# Step 1 — Set up the bench

Install `pip`, then scikit-learn and numpy — the classical toolbox's lingua franca. scikit-learn ships
toy datasets (iris, digits, breast-cancer) *inside* the package, so nothing is downloaded.

```bash
apt-get update -qq && apt-get install -y python3-pip >/dev/null 2>&1
```{{exec}}

```bash
pip install scikit-learn numpy
```{{exec}}

Make a working directory — everything in this lab lives here:

```bash
mkdir -p ~/ml-lab && cd ~/ml-lab
```{{exec}}

Confirm the install worked and see the versions:

```bash
python3 -c "import sklearn, numpy; print('sklearn', sklearn.__version__, '- numpy', numpy.__version__)"
```{{exec}}

You now have a full machine-learning toolbox on a plain CPU. No GPU, no downloads — everything below runs
in seconds.

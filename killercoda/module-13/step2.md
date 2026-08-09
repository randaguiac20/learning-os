# Step 2 — Install a package into the venv

With the venv active, install a real package — **pytest**, the testing tool you'll use next. It lands in
the venv's `site-packages`, not the system.

First let pip update itself (inside the venv):

```bash
python -m pip install --upgrade pip
```{{exec}}

Install the package:

```bash
pip install pytest
```{{exec}}

See what now lives in *this* environment — pytest and the handful of packages it pulled in:

```bash
pip list
```{{exec}}

Prove it's importable by the venv's interpreter:

```bash
python -c "import pytest; print('pytest', pytest.__version__)"
```{{exec}}

Everything `pip list` shows lives under `~/recall/.venv/lib/…` — delete `.venv` and it's all gone,
system untouched. Every `pip install` is a **trust decision**: install what you *mean*, and (for things
you ship) pin the versions so tomorrow's build matches today's.

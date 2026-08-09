# Step 1 — Build an isolated environment

Before any packages, the golden rule: **never `pip install` into the system Python.** Instead, give the
project its own interpreter — a **virtual environment**.

Confirm the interpreter is here:

```bash
python3 --version
```{{exec}}

Make sure the `venv` and `pip` modules are available (harmless if already installed):

```bash
apt-get update -qq && apt-get install -y python3-venv python3-pip
```{{exec}}

Create the project and its isolated environment:

```bash
mkdir -p ~/recall && cd ~/recall
```{{exec}}

```bash
python3 -m venv .venv
```{{exec}}

```bash
source .venv/bin/activate
```{{exec}}

Now prove the isolation — `which python` must point *inside* `~/recall/.venv`:

```bash
which python
```{{exec}}

Your prompt now shows `(.venv)`. From here on, `python` and `pip` mean the **venv's** copies — nothing
you install touches the system interpreter every other tool on the machine depends on.

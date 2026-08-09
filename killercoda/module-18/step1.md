# Step 1 — A repo that sets itself up

Make a tiny Python repo — the thing that will get a bench:

```bash
mkdir -p ~/hello-bench && cd ~/hello-bench
```{{exec}}

```bash
git init -q
```{{exec}}

```bash
printf 'print("hello from the bench")\n' > app.py
```{{exec}}

```bash
printf 'ruff\npytest\n' > requirements-dev.txt
```{{exec}}

```bash
mkdir -p .devcontainer
```{{exec}}

```bash
ls -la
```{{exec}}

**The "before" measurement.** On a bare machine, working on this repo means: install Python, make a
venv, `pip install` the dev tools, wire pre-commit, set up the editor — minutes of archaeology, and it
rots. Those steps are the spec's **TODO list**: the `devcontainer.json` you write next turns them into
one file that any tool can execute.

The spec is per-**repo** (it lives in `.devcontainer/`), not per-machine — machine-level config belongs
in your dotfiles, the repo's bench belongs here.

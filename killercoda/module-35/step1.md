# Step 1 — Set up the bench (pytest + git)

Professional work happens in a **repo** with a **test runner**. Install both, then make a throwaway
project directory:

```bash
apt-get update -qq && apt-get install -y python3-pip git
```{{exec}}

```bash
pip install pytest
```{{exec}}

```bash
mkdir -p ~/tdd-lab && cd ~/tdd-lab
```{{exec}}

Initialise a git repo so you can make **atomic commits** (one logical change each) as you go:

```bash
git init -q && git config user.email you@example.com && git config user.name "You"
```{{exec}}

Confirm the test runner is installed:

```bash
python3 -m pytest --version
```{{exec}}

You now have a real repo (**git**, M8) and **pytest** in place. Everything from here lives inside
`~/tdd-lab/` — a sandbox you can delete when you're done.

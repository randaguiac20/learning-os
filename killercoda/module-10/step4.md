# Step 4 — Pin a project's runtime with mise

chezmoi owns your *config*; **mise** owns your *tools*. A project declares its runtime versions in a
`mise.toml`, and mise auto-switches `PATH` when you `cd` into the directory — the system's own tools stay
untouched.

Make a demo project and write its version contract:

```bash
mkdir -p ~/dotfiles-lab/mise-demo && cd ~/dotfiles-lab/mise-demo
```{{exec}}

```bash
cat > mise.toml <<'EOF'
[tools]
python = "3.11"
node = "22"
EOF
```{{exec}}

```bash
cat mise.toml
```{{exec}}

See what mise resolves for **this** directory (it installs on first use), and read the truth about which
`python` a shell would run:

```bash
mise ls
```{{exec}}

```bash
which -a python || true
```{{exec}}

This `mise.toml` **is** the reproducibility contract: a teammate runs `mise install` in the repo and gets
identical tools — "works on my machine" retired for runtimes.

### Prove asdf compatibility (bonus)

mise reads asdf's `.tool-versions` format natively — no conversion:

```bash
mkdir -p ~/dotfiles-lab/asdf-demo && cd ~/dotfiles-lab/asdf-demo
```{{exec}}

```bash
printf 'python 3.11.9\nnode 22.0.0\n' > .tool-versions
```{{exec}}

```bash
mise ls
```{{exec}}

> Layering (M13 formalises it): **system** Python belongs to apt; **mise** picks the *interpreter
> version*; a **venv** isolates *packages* on top. Three layers, no conflict — `which -a` reads the stack.

Click **Check** to verify your `mise.toml` exists and pins a Python version.

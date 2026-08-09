# Step 1 — Install the managers

Both tools are **single Go/Rust binaries** — no runtime, no plugins to bootstrap. Install chezmoi
straight to a directory on your `PATH`:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
```{{exec}}

```bash
chezmoi --version
```{{exec}}

Now mise. Its installer drops the binary in `~/.local/bin`; we put that on `PATH` and load the
**activation hook** (the shell hook that rewrites `PATH` per directory) for this session:

```bash
curl -fsSL https://mise.run | sh
```{{exec}}

```bash
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"
```{{exec}}

```bash
mise --version
```{{exec}}

Both tools ship real diagnostics — run each once now, while everything is healthy, so you recognise
*sick* later:

```bash
chezmoi doctor
```{{exec}}

```bash
mise doctor
```{{exec}}

> If a network install is slow, give it a moment and re-run the version check. In real life the mise
> activation line goes into your `.bashrc` — managed by chezmoi, naturally, so every future shell has it.

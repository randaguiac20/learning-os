# Step 1 — Check your Vim and meet the modes

First, is full Vim installed (not `vim-tiny`)? Install it if needed, and check for `+clipboard`:

```bash
vim --version | head -3 || true
```{{exec}}

```bash
apt-get update -y >/dev/null 2>&1 && apt-get install -y vim >/dev/null 2>&1; vim --version | grep -o '[+-]clipboard'
```{{exec}}

Make your sandbox — all practice lives here:

```bash
mkdir -p ~/vim-lab && cd ~/vim-lab
```{{exec}}

Now meet the modes. Create a small file and open it in Vim:

```bash
printf 'one\ntwo\nthree\n' > modes.txt
```{{exec}}

```bash
vim modes.txt
```{{exec}}

**Inside Vim**, feel the mode map — note *where* each insert lands, and return home each time:

- `i` insert **before** the cursor · `a` **after** · `o` new line **below** · `O` **above** → then `Esc`
- `v` (char), `V` (line), `Ctrl-v` (block) select → then `Esc`
- `:` opens the command-line → then `Esc` to cancel

Do a dozen round-trips until **`Esc`** is automatic — Normal mode is *home*. Meet two classic traps on
purpose: press `q` then a letter (you're **recording** a macro — `q` again stops it), and `Ctrl-s`
(terminal **frozen** — `Ctrl-q` thaws it; that's flow control from Module 02).

When done, leave without saving:

```
:q!
```

> Optional but recommended: run `vimtutor` for the official 30-minute hands-on lessons 1–7. It edits a
> throwaway copy of its own text, so every mistake is safe. Quit it with `:q` when finished.

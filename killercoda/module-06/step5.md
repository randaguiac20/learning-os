# Step 5 — Your first vimrc, and leaving on purpose

Your lasting artifact from this module is `~/.vimrc` — built **line by line as friction appears**, every
line commented with the pain it solves. Never paste a 300-line config you can't explain; you can only
maintain what you understand.

Create a small, honest starter (every line earns its place):

```bash
cat > ~/.vimrc <<'EOF'
" show line numbers, relative so counted motions like 5j are readable off the screen
set number relativenumber
" search that helps: jump as you type, highlight, case-insensitive unless you Type a Capital
set incsearch hlsearch ignorecase smartcase
" switch buffers without being nagged to save first
set hidden
" turn on syntax colours
syntax on
EOF
cat ~/.vimrc
```{{exec}}

Open a file and see the config take effect (line numbers, live search with `/`):

```bash
vim ~/vim-lab/hosts.txt
```{{exec}}

Try `:set relativenumber?` to confirm it's on, and `/web` then `n` to feel `incsearch`/`hlsearch`.
Inside a running Vim you can reload the config after editing it with `:source $MYVIMRC`.

**Leaving on purpose — the whole "how do I exit Vim?" mystery, solved.** From Normal mode (`Esc` first
if unsure):

| Command | Effect |
|---|---|
| `:w` | write (save), stay in the file |
| `:q` | quit — refuses if there are unsaved changes |
| `:wq` or `ZZ` | write **and** quit |
| `:x` | write only if changed, then quit |
| `:q!` | quit **discarding** all changes |

Quit now:

```
:q
```

You configured Vim with lines you can explain, and you can enter and leave it deliberately. That's the
foundation the whole rest of the curriculum is edited on.

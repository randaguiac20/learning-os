#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the loop was drilled and private_ enforced 600.
src="$HOME/.local/share/chezmoi"
[ -d "$src" ] || { echo "chezmoi source state not found at $src — run 'chezmoi init' (Step 2)."; exit 1; }
[ -f "$src/dot_vimrc" ] || { echo "Source file dot_vimrc missing — add it with: chezmoi add ~/.vimrc (Step 2)."; exit 1; }
grep -q 'syntax on' "$src/dot_vimrc" || { echo "dot_vimrc has no 'syntax on' — edit the SOURCE then apply (Step 3)."; exit 1; }
[ -f "$HOME/.vimrc" ] || { echo "~/.vimrc not found — run 'chezmoi apply' to render it from source (Step 3)."; exit 1; }
grep -q 'syntax on' "$HOME/.vimrc" || { echo "~/.vimrc is stale — run 'chezmoi apply' so the source change lands (Step 3)."; exit 1; }
[ -f "$HOME/.ssh/config" ] || { echo "~/.ssh/config not found — create and 'chezmoi add' it (Step 3)."; exit 1; }
mode=$(stat -c '%a' "$HOME/.ssh/config")
[ "$mode" = "600" ] || { echo "~/.ssh/config mode is $mode, expected 600 — the private_ attribute enforces it (Step 3)."; exit 1; }
echo "Verified: source edited, ~/.vimrc applied from it, and ~/.ssh/config is 600. The loop works."
exit 0

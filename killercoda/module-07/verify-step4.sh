#!/bin/bash
# Killercoda step verifier: pass (exit 0) when ~/.tmux.conf contains the earned lines and the reload binding.
conf="$HOME/.tmux.conf"
[ -f "$conf" ] || { echo "~/.tmux.conf not found — create it as shown in Step 4."; exit 1; }
grep -Eq 'mode-keys[[:space:]]+vi' "$conf"                 || { echo "Missing 'mode-keys vi' — add: setw -g mode-keys vi"; exit 1; }
grep -Eq 'escape-time[[:space:]]+0' "$conf"                || { echo "Missing 'escape-time 0' — add: set -sg escape-time 0"; exit 1; }
grep -Eq 'default-terminal[[:space:]]+"?tmux-256color' "$conf" || { echo "Missing 'default-terminal tmux-256color' — add: set -g default-terminal \"tmux-256color\""; exit 1; }
grep -Eq 'base-index[[:space:]]+1' "$conf"                 || { echo "Missing 'base-index 1' — add: set -g base-index 1"; exit 1; }
grep -Eq 'bind[[:space:]]+r[[:space:]]+source-file' "$conf" || { echo "Missing the reload binding — add: bind r source-file ~/.tmux.conf \\; display \"reloaded\""; exit 1; }
echo "Verified: ~/.tmux.conf carries mode-keys vi, escape-time 0, tmux-256color, base-index 1, and a prefix-r reload binding. Config as code."
exit 0

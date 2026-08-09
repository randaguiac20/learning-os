# Step 4 — An earned ~/.tmux.conf

Config is code: every line earned from real friction, every line commented. Write the Vim user's
first-three plus a reload key. Each fixes something concrete.

```bash
cat > ~/.tmux.conf <<'EOF'
# --- earned, one line at a time ---
setw -g mode-keys vi                        # copy-mode uses vi keys (the M6 dividend)
set -sg escape-time 0                        # no Esc lag inside Vim
set -g default-terminal "tmux-256color"      # correct colors (fixes washed-out Vim)
set -g base-index 1                          # window numbers start at 1, match the keyboard
bind r source-file ~/.tmux.conf \; display "reloaded"   # a reload key: prefix r
EOF
```{{exec}}

Look at what you wrote:

```bash
cat ~/.tmux.conf
```{{exec}}

Apply it to a running server and confirm tmux actually accepted the options (no attach needed):

```bash
tmux kill-server 2>/dev/null; tmux new-session -d -s cfg
tmux source-file ~/.tmux.conf
```{{exec}}

```bash
tmux show-options -g base-index
tmux show-options -g default-terminal
tmux show-options -gw mode-keys
```{{exec}}

`base-index 1`, `tmux-256color`, and `mode-keys vi` should be reported back — the config took. At the
keyboard you'd reload live with your new **`prefix r`** binding after every edit (the daemon-reload
rhyme from M4: change the file, then tell the server to re-read it).

Click **Check** to verify `~/.tmux.conf` contains the earned lines and the reload binding.

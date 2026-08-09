#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the headless 'dev' layout and the send-keys marker exist.
tmux has-session -t dev 2>/dev/null || { echo "Session 'dev' not found — build it with: tmux new-session -d -s dev -n edit"; exit 1; }
tmux list-windows -t dev -F '#{window_name}' 2>/dev/null | grep -qx run || { echo "Window 'run' not found in 'dev' — add it with: tmux new-window -t dev -n run"; exit 1; }
panes=$(tmux list-panes -t dev:run 2>/dev/null | wc -l)
[ "$panes" -ge 2 ] || { echo "The 'run' window has $panes pane(s), expected 2 — split it with: tmux split-window -v -t dev:run"; exit 1; }
marker="$HOME/dev-run.marker"
[ -f "$marker" ] || { echo "Marker $marker not found — deliver it with: tmux send-keys -t dev:run.1 'echo pane-ready > ~/dev-run.marker' Enter"; exit 1; }
grep -q "pane-ready" "$marker" || { echo "Marker exists but has the wrong content — re-run the send-keys command from Step 3."; exit 1; }
echo "Verified: session 'dev' has a 'run' window split into $panes panes, and send-keys wrote the marker. You scripted a workspace."
exit 0

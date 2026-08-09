# Step 2 — Session, window, and pane lifecycle

The containment hierarchy: **server ⊃ sessions ⊃ windows ⊃ panes.** Build it with commands (the same
commands the keys are bound to), so you see every level.

Create two named sessions, detached:

```bash
tmux new-session -d -s learn
tmux new-session -d -s ops
```{{exec}}

```bash
tmux ls
```{{exec}}

Add named **windows** to `learn` (a window is a full-screen tab — `prefix c` at the keyboard):

```bash
tmux new-window -t learn -n edit
tmux new-window -t learn -n run
tmux list-windows -t learn
```{{exec}}

Split the `run` window into **panes** — each pane is its own pty running its own shell (`prefix %` / `"`
interactively):

```bash
tmux split-window -h -t learn:run
tmux split-window -v -t learn:run
tmux list-panes -t learn:run
```{{exec}}

Now the lesson every beginner learns the hard way — **`exit` is not `detach`.** Kill just the last pane
you made, and watch the pane count drop while the session and server live on:

```bash
tmux send-keys -t learn:run 'exit' Enter
sleep 1
tmux list-panes -t learn:run
```{{exec}}

`exit` ended that pane's shell. At the keyboard you'd use **`prefix d`** to *leave everything running* —
detach, don't exit. Tidy up one whole session to feel `kill-session`:

```bash
tmux kill-session -t ops
tmux ls
```{{exec}}

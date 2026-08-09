# Step 3 — Build a layout headless with send-keys

**Keys are commands** — so a whole workspace can be built from a script, with no keyboard. The trick is
`-d` (detached) creation: build the session while nothing is attached, so your commands can keep
targeting it, and only attach at the very end.

Build the `dev` layout — window `edit`, plus a `run` window split into two panes:

```bash
tmux new-session -d -s dev -n edit
tmux new-window  -t dev -n run
tmux split-window -v -t dev:run
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}'
```{{exec}}

Now **`send-keys`** types into a pane programmatically — this is how a layout script launches programs
(vim, a log follow, a build). Send a command into the top pane of `run` and press Enter for it:

```bash
tmux send-keys -t dev:run.1 'echo pane-ready > ~/dev-run.marker' Enter
```{{exec}}

The keystrokes were delivered to that pane's shell, which ran them — leaving a real file behind. Confirm
from *outside* tmux:

```bash
sleep 1; cat ~/dev-run.marker
```{{exec}}

That is the entire mechanism behind `workstation.sh`: `new-session -d` → `new-window` / `split-window`
→ `send-keys` to launch each pane's program → (a script would `attach` last). You just scripted a
workspace.

Click **Check** to verify the `dev` session, its `run` window's two panes, and the `send-keys` marker.

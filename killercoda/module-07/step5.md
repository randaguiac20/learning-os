# Step 5 — Observe, clean up, and hygiene

Your workspace is inspectable like everything else you operate. From **outside** tmux, produce a fleet
report of every pane — where it is, its PID, and what's running:

```bash
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_pid} #{pane_current_command}'
```{{exec}}

The `#{…}` tokens are tmux's FORMATS mini-language (skim `man tmux` FORMATS for 15 minutes some day —
change one on purpose). Cross-check one pane's PID against the process tree (M3):

```bash
pstree -p $(pgrep -x tmux | head -1)
```{{exec}}

**Scrollback hygiene.** Everything a pane displayed is retained — including secrets you `cat`-ed. On
shared boxes, scrub it after sensitive output:

```bash
tmux new-session -d -s secret 'echo PRETEND_SECRET=hunter2; sleep 300'
tmux send-keys -t secret 'clear-history' # (at the keyboard: prefix : clear-history)
tmux clear-history -t secret
echo "history scrubbed for session 'secret'"
```{{exec}}

**The socket** is what makes all of this possible — and what pairing shares. Inspect its permissions
(mode 700, owned by you — M3 doing real work):

```bash
ls -la /tmp/tmux-$(id -u)/
```{{exec}}

Socket access = the ability to command the server = **every shell in every session**. That is why 700
matters, and why cross-user pairing is a deliberate act.

**Session hygiene** is the daily rep: `tmux ls` every evening, then name it, keep it, or kill it. Clean
up this lab's sessions now:

```bash
tmux kill-server
tmux ls 2>/dev/null || echo "no server running — all sessions cleaned up"
```{{exec}}

You installed tmux, proved persistence, ran the full lifecycle, scripted a layout with `send-keys`,
wrote an earned config, and inspected and cleaned your workspace. That's Module 07, hands-on.

# Tmux — hands-on

You have a real Linux machine in the terminal on the right. **tmux** (terminal multiplexer) is a *server*
that hosts terminal sessions independently of any window: one terminal can show many, you can **detach**
and **reattach** with everything still running, and every action is a **command** you can script.

In the next few minutes you'll install tmux, prove persistence, run the session/window/pane lifecycle,
build a whole layout **headless** with `new-session -d` and `send-keys`, write an earned `~/.tmux.conf`,
and inspect your workspace from the outside.

This lab drives tmux the **scriptable** way — `tmux new-session -d`, `send-keys`, `split-window`,
`list-panes`, and a config file — so each step leaves real state the checker can verify (a session, a
window, a pane, a config binding). Everything is created under your home; nothing outside it is touched.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.
> Remember the one rule that trips up everyone: `exit` *kills* a shell; **`prefix d`** (Ctrl-b then d)
> *detaches* and leaves it running.

Click **START** to begin.

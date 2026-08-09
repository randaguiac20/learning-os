# Step 1 — Install tmux and prove persistence

Install tmux and check the version (note yours versus the current 3.7b):

```bash
apt-get update && apt-get install -y tmux
```{{exec}}

```bash
tmux -V
```{{exec}}

**Now the whole point of the module: persistence.** Start a detached session with something visibly
alive inside it — a clock that ticks — *without* attaching:

```bash
tmux new-session -d -s proof 'while true; do date > /tmp/proof.log; sleep 1; done'
```{{exec}}

The session is running even though no terminal is showing it. Confirm it exists, then watch the file it
keeps updating:

```bash
tmux ls
```{{exec}}

```bash
cat /tmp/proof.log; sleep 2; cat /tmp/proof.log
```{{exec}}

The two timestamps differ — the process is alive **with no client attached**. See the mechanism: the
server owns that process (it is a child of tmux, not of your shell):

```bash
pstree -p $(pgrep -x tmux | head -1)
```{{exec}}

That parenthood is *why* closing a terminal or dropping an SSH connection never kills tmux work: the
hangup goes to the disposable **client**, never to the **server** holding your processes.

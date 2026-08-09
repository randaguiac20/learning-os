# SSH — hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll turn it into
**both** ends of an SSH connection: install a real **SSH server** (`sshd`), generate your own **Ed25519
key**, log in with **no password**, name the host in `~/.ssh/config`, and open a **tunnel** — all against
`localhost`, so you need no second machine to learn the whole flow.

Every connection you make here performs the **two authentications** that are the heart of SSH: first the
**server** proves itself (its host key), then **you** prove yourself (a signature from your key —
*never* a secret sent over the wire).

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> reading each command before you run it is the habit that keeps you out of trouble on real servers.

Click **START** to begin.

# Networking — inspect your own stack

You have a real Linux machine on the right, with its own network interfaces, a route table, a loopback,
and everything needed to run a small server and talk to it. In the next few minutes you'll read your
machine's network identity from the link layer up, resolve names (and fake one with `/etc/hosts`), start
a real HTTP listener, drive a request with `curl -v`, and watch the actual packets on the wire.

**Everything runs on YOUR machine and YOUR loopback** — the capture ethics line is simple and binding:
*your machine, your traffic, full stop*. No other host is ever touched.

> Tip: **type every command yourself** — reading `ip`, `ss`, `dig`, and `curl` output is the skill;
> pasting past it skips the part that builds the memory.

Click **START** to begin.

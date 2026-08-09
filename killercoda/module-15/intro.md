# Automation — hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll cross the line
from *"I have scripts"* to *"I run unattended systems"*: you'll prove a job **idempotent** with a
run-twice diff, put a **tested** script on a **cron** schedule, then write an **Ansible** play that
declares desired state and converges to `changed=0` on its second run.

**Everything happens inside a throwaway `~/automation-lab/` sandbox you create** — nothing outside it is
touched. The one rule that runs through the whole lab: **only a job that survives its own second run
belongs on a schedule.**

> This container has no `systemd` as PID 1, so we schedule with **cron** (which runs anywhere). In
> production you'd prefer **systemd timers** for logging and catch-up — the concepts are identical.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> pasting multi-line text can run commands before you've read them.

Click **START** to begin.

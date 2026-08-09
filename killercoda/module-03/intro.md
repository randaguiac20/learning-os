# Linux Essentials — hands-on

You have a real Linux machine in the terminal on the right, with `root`/`sudo` available. In the next
few minutes you'll live the **four pillars** every admin stands on: **files** (the FHS layout and
inodes), **permissions** (mode bits and the directory-`w` surprise), **software** (the apt lifecycle),
and **processes** (jobs and signals).

**Everything that creates, links, or changes files happens ONLY inside a throwaway
`~/learning/labs/m3/` sandbox you build first** — nothing outside it is touched. Read-only commands
(`ls`, `stat`, `find`, `dpkg -L`) inspect and change nothing, so be curious.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> reading each command before you run it is the safety habit this whole module is built on. When a step
> uses `sudo`, read it aloud and say what it touches first.

Click **START** to begin.

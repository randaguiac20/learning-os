# Linux Administration — hands-on

You have a real Linux machine on the right — a full VM with **systemd** as PID 1 and **root/`sudo`**
available. This is the operator's playground: in the next 30-45 minutes you'll survey what the system is
doing, **author a systemd unit**, read your own program's output in the **journal**, put a service on a
**timer**, build a **persistent storage mount** (device → filesystem → mount → fstab), and take a
**backup with a real restore drill**.

**This scenario uses `sudo` for real admin work** — creating a service user, writing units under
`/etc/systemd/system/`, formatting a loopback disk, editing `fstab`. Read every command before you run
it. All storage work is done on a throwaway **loopback file**, so nothing on the real disks is touched —
the professional habit (a disposable VM with snapshots) is baked in.

> Tip: **type every command yourself** — don't copy-paste. Typing is how the memory forms, and pasting
> multi-line text can run commands before you've read them.

Click **START** to begin.

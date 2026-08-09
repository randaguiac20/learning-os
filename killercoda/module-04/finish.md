# Done — you operated a machine

In one session you:

- **Surveyed** the running system — services, `--failed`, `list-timers`, and the journal — the "what is
  this machine doing?" reflex.
- **Authored a systemd unit** and saw `enable` vs `start` as two independent axes (boot-wiring vs now).
- Read your own program's output **in the journal**, stamped and queryable by unit.
- Put a service on a **timer** with `Persistent=true`, `[Install]` correctly on the timer.
- Built the **storage stack** end to end — device → ext4 → mount → **fstab by UUID** with `nofail`,
  tested with `mount -a`.
- Took a **backup and ran the restore drill** — `tar -tvf` before extract, `rsync --dry-run` first,
  delta-fast second run, and a `diff`-clean restore that made the backup real.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back), attempt the *Solo Lab* challenges
(a VM with snapshots for the storage/chaos ones), and tick the *Mastery checklist*. When every box is
honestly true, Module 05 (Bash Scripting) — the stage finale — becomes current.

> The one-sentence takeaway: **M4 is single-machine Kubernetes — desired state, supervision, schedules,
> and durable storage — learn the reconciliation instinct here, where the whole system still fits in your
> head.**

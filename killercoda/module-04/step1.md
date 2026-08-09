# Step 1 — Survey services, timers, and the journal

Before you change anything, ask: *what is this machine doing?* These commands are read-only.

What services are alive right now?

```bash
systemctl list-units --type=service --state=running
```{{exec}}

Is anything broken? (This one joins your daily morning ritual.)

```bash
systemctl --failed
```{{exec}}

What's already scheduled on this machine?

```bash
systemctl list-timers
```{{exec}}

Read one service closely — `status` fuses its state **and** its recent log lines:

```bash
systemctl status ssh --no-pager
```{{exec}}

Now the journal — this boot's tail, then just the errors:

```bash
journalctl -b --no-pager | tail -20
```{{exec}}

```bash
journalctl -p err -b --no-pager | tail
```{{exec}}

**Read the `status` output and answer (in your head or a journal):**

- Which line says **`loaded`**, which says **`enabled`**, and which says **`active (running)`**? Those are
  three different facts — a unit can be `enabled` (starts at boot) yet not `active` right now, and vice
  versa.
- The journal is not a flat text file: it's stamped and indexed, which is why `-u`, `-b`, `-p`, and `-f`
  can filter by unit, boot, priority, and follow. Keep that in mind — it's your first stop for every
  failure.

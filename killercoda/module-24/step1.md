# Step 1 — Map the attack surface

You cannot secure what you haven't enumerated. Security starts with **instruments, not memory** — this
snapshot is your **baseline**, and everything after is a measured delta.

Every listening socket is a doorway:

```bash
ss -tlnp
```{{exec}}

What escalation do you hold, and who are you?

```bash
sudo -l
```{{exec}}

```bash
id
```{{exec}}

Every SUID binary runs with its owner's power regardless of who launches it — enumerate them:

```bash
find / -perm -4000 -type f 2>/dev/null
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- Which listeners do you *recognize*? An unrecognized one is a hypothesis to investigate, not a thing to
  blindly kill.
- Which SUID files are the normal system set (`sudo`, `passwd`, `mount`, `su`) versus a **surprise**?
- `id` shows your groups — membership in `sudo`/`adm` is standing power.

This is the "quit thinking and look" discipline from Module 23, applied to security. Nothing here
changes the system — read-only recon is always safe.

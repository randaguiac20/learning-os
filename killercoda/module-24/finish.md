# Done — you ran the hardening loop

In ~30 minutes you:

- **Mapped the attack surface** with instruments — `ss -tlnp`, `sudo -l`, `id`, `find / -perm -4000` —
  not from memory.
- Added a **least-privilege user** (`webops`) with no sudo grants — the blast radius stops at the app.
- **Fixed a leak**: an over-permissioned secret hardened to `0600` root-owned, and a **SUID-root**
  surprise stripped of its bit — verifying with `ls -l` each time.
- Stood up a **default-deny firewall** the **lockout-safe** way — SSH allowed *before* the firewall was
  enabled.
- Hardened `sshd` to **keys-only, no root login**, validated with **`sshd -t` before reload**.
- **Re-audited** every change — the measured delta is the proof.

**Back on the lesson page:** do the *Self-Check* (recall + the "minimum key" teach-back) and tick the
*Mastery checklist*. When every box is honestly true you've shipped the host chapter of **the
Fortress** — Stage 9 closes at Module 25, when the Watchtower (observability) goes up beside it.

> The one-sentence takeaway: **you must be right everywhere and the attacker needs to be right once — so
> you build in layers, justify every wall, and watch for the day one falls.**

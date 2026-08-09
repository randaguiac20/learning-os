# Step 5 — Re-audit — measure the delta

The hardening loop is **audit → one change → re-audit → document**. You've made the changes; now the
**second look** proves them. The delta is the evidence — measured, not asserted.

What still listens, compared to Step 1?

```bash
ss -tlnp
```{{exec}}

The firewall's live policy:

```bash
sudo ufw status verbose
```{{exec}}

The **effective** sshd config (not just the file — what the daemon will actually enforce):

```bash
sudo sshd -T | grep -Ei 'passwordauthentication|permitrootlogin'
```{{exec}}

The SUID surprise should be gone from `/opt`:

```bash
find / -perm -4000 -type f 2>/dev/null | grep -v /opt/app && echo "-- /opt/app is clean --" || echo "-- /opt/app SUID removed; only system SUID files remain --"
```{{exec}}

**The habit that outlives this lab:** write **one justification line per change** — why it exists, what
it costs, what breaks if it's wrong. That journal *is* the Fortress doc. A change you can't justify is
debt: learn why it's there, or remove it. Security you can't explain is a different kind of broken.

You enumerated a real attack surface, applied least privilege three ways (a minimal user, `0600` on a
secret, a stripped SUID bit), stood up a default-deny firewall the lockout-safe way, and hardened `sshd`
with validation before reload. That's the hardening loop, in anger.

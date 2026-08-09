# Step 2 — Add a least-privilege user

Root does everything; a service should do **almost nothing**. Least privilege means every identity gets
the minimum it needs — so a service that owns one app should **not** hold the keys to the whole host.

Create a named, minimal user — not in the `sudo` group, no `NOPASSWD`:

```bash
sudo useradd -m -s /bin/bash webops
```{{exec}}

Confirm the identity holds no admin power:

```bash
id webops
```{{exec}}

```bash
sudo -l -U webops 2>/dev/null || echo "webops holds no sudo grants — good"
```{{exec}}

`id webops` should show **only** its own primary group — no `sudo`, `adm`, or `wheel`. That is least
privilege in one uniform: `webops` can own and run a service, but if it were ever compromised, the
**blast radius** stops there. The bakers don't hold the gate keys.

> Contrast: adding a user to `sudo` with `NOPASSWD` is a standing hole — full root power, no challenge,
> forever. Every privilege you grant is a wall you must later defend, so grant the minimum.

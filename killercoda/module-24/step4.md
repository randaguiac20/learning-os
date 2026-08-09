# Step 4 — Lock the doors — firewall and sshd

Two network-facing controls, both fail-safe by default-deny. **The lockout law rules this step:** allow
the door **before** you close the firewall, and validate `sshd` **before** you reload it.

Install the tools, then set a **default-deny** firewall — allowing SSH *first*:

```bash
sudo apt-get update -qq && sudo apt-get install -y -qq ufw openssh-server
```{{exec}}

```bash
sudo ufw default deny incoming && sudo ufw default allow outgoing
```{{exec}}

```bash
sudo ufw allow OpenSSH
```{{exec}}

```bash
sudo ufw --force enable
```{{exec}}

```bash
sudo ufw status verbose
```{{exec}}

Confirm `Default: deny (incoming)` and an `OpenSSH ALLOW` rule — the one door we keep open. Now harden
`sshd` with a drop-in: **keys-only, no root login**, and **`sshd -t` before touching the daemon**:

```bash
printf 'PasswordAuthentication no\nPermitRootLogin no\nMaxAuthTries 3\n' | sudo tee /etc/ssh/sshd_config.d/99-hardening.conf
```{{exec}}

```bash
sudo sshd -t && echo "config OK"
```{{exec}}

```bash
sudo systemctl reload ssh 2>/dev/null || sudo systemctl reload sshd 2>/dev/null || true
```{{exec}}

> On a machine you reach **only** by SSH you would first verify **key** login in a second session while
> passwords were still on — never disable password auth before the key works. In this disposable lab it
> is safe; the *order* is the lesson.

Click **Check** to verify the firewall is default-deny with SSH allowed and `sshd` is keys-only,
no-root, and passes `sshd -t`.

# Step 1 — Bring the server up, meet its identity

SSH has two ends: the **client** (`ssh`, already here) and the **server** (`sshd`). Install and start the
server — it's just a service, exactly like the units from Module 04:

```bash
apt-get update && apt-get install -y openssh-server
```{{exec}}

```bash
service ssh start
```{{exec}}

```bash
service ssh status
```{{exec}}

Every server has its own **identity** — a *host key*. Look at its fingerprint; this is what proves the
server to you:

```bash
ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
```{{exec}}

Now the first connection. Because you've never met this host, SSH pins its key into `known_hosts` —
**Trust On First Use (TOFU)**. `accept-new` records the pin without a prompt:

```bash
ssh -o StrictHostKeyChecking=accept-new localhost true
```{{exec}}

```bash
cat ~/.ssh/known_hosts
```{{exec}}

That was **authentication #1**: your client verified the server's host key and pinned it. On a real box
you'd compare that fingerprint **out-of-band** (a console, the cloud panel) *before* trusting it — a
later *changed*-key warning is the one alarm you never ignore.

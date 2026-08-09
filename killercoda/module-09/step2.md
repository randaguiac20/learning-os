# Step 2 — Generate your Ed25519 identity

You logged in with the server's *default* password before pinning. Now build the professional way in: a
**key pair**. **Ed25519** is the modern default — short, fast, strong:

```bash
ssh-keygen -t ed25519 -C "you@lab-$(date +%Y%m)" -N "" -f ~/.ssh/id_ed25519
```{{exec}}

Two files were written. Look at them, and at their **permissions**:

```bash
ls -l ~/.ssh
```{{exec}}

```bash
file ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
```{{exec}}

The `.pub` file is your **public** half — it travels freely. The other file is your **private** key: it
**never leaves this machine**, and SSH insists it stay `600` (and `~/.ssh` stay `700`) or it refuses to
use it. Your own fingerprint:

```bash
ssh-keygen -l -f ~/.ssh/id_ed25519.pub
```{{exec}}

> **Lab shortcut:** we used `-N ""` (empty passphrase) so every later `ssh` just works. On a real key
> you set a passphrase and load it into the **ssh-agent** once per login (`ssh-add`) — you'll do exactly
> that in the Solo Lab back on the lesson page. **Never** copy a private key between machines: generate
> one per device, and only the public half travels.

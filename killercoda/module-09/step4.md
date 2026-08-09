# Step 4 — Name the host in your config

Typing `ssh -i ~/.ssh/id_ed25519 root@127.0.0.1` every time is a chore. `~/.ssh/config` turns a host into
a short **alias** that carries its address, user, and key. Write a `Host` block:

```bash
cat >> ~/.ssh/config <<'EOF'
Host mybox
    HostName 127.0.0.1
    User root
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF
```{{exec}}

```bash
chmod 600 ~/.ssh/config
```{{exec}}

See what you wrote, then connect with the **bare alias**:

```bash
cat ~/.ssh/config
```{{exec}}

```bash
ssh -o StrictHostKeyChecking=accept-new mybox 'echo connected as $USER on $(hostname)'
```{{exec}}

`ssh mybox` now carries everything — nothing to remember or type. `IdentitiesOnly yes` tells the client to
offer **only** this key, which is faster, quieter, and avoids `MaxAuthTries` lockouts when an agent holds
many keys. A real config becomes the **README of your infrastructure**: one commented block per machine.

Click **Check** to verify your `Host` block is present and the alias logs in with the key.

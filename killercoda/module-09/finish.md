# Done — the network disappeared

In ~30 minutes you:

- Installed and started **sshd**, and met the server's **host key** — how the server proves itself to you.
- Generated an **Ed25519** keypair and read what each half is for.
- Authorized your key and logged in **password-free**, watching the sign-the-challenge handshake happen.
- Aliased the host in **`~/.ssh/config`** so `ssh mybox` carries address, user, and key — the README of
  your infrastructure.
- Opened an **`-L` tunnel** to a private service and watched the **auth log** record every attempt.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back), work the *Solo Lab* (harden
sshd to keys-only, agent forwarding, a `ProxyJump` chain), and tick the *Mastery checklist*. When every
box is honestly true, Module 10 (Dotfiles & Toolchains) — one bootstrap command over this exact
transport — becomes current.

> The one-sentence takeaway: **M9 makes the network disappear — with keys, config, tmux, and Git
> converging over SSH, "this machine" and "that machine" become one workspace.**

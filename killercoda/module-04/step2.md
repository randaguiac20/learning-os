# Step 2 — Author a unit — enable vs start

A **unit** is a declarative file systemd manages. Create a dedicated system user (least privilege, from
M3), then write your first unit:

```bash
sudo useradd -r -s /usr/sbin/nologin caretaker
```{{exec}}

```bash
sudo tee /etc/systemd/system/hello-care.service >/dev/null <<'EOF'
[Unit]
Description=Caretaker heartbeat
[Service]
Type=oneshot
ExecStart=/bin/echo "Caretaker alive"
User=caretaker
EOF
```{{exec}}

systemd caches units in memory, so after writing a file you must reload before it exists to PID 1:

```bash
sudo systemctl daemon-reload
```{{exec}}

Now **start** it (launch now) and read the result:

```bash
sudo systemctl start hello-care
```{{exec}}

```bash
systemctl status hello-care --no-pager
```{{exec}}

**enable vs start — two independent axes.** Check them directly:

```bash
systemctl is-active hello-care
```{{exec}}

```bash
systemctl is-enabled hello-care
```{{exec}}

`start` launched it now; it is **not** wired for boot (`is-enabled` says `static`/`disabled`). `enable`
would create a symlink so a target *wants* it at boot — a different thing entirely. See the real loaded
content, drop-ins included:

```bash
systemctl cat hello-care
```{{exec}}

> The `[Install]` section is what `enable` acts on; `[Service]` is what `start` acts on. Conflating the
> two ("it worked until I rebooted") is the #1 beginner mistake.

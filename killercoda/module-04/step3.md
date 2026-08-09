# Step 3 — A health service on a timer

A program that runs itself on a schedule is a **two-part machine**: a `.service` that does the work and a
`.timer` that pulls it. First the payload script — note it must be **executable**:

```bash
sudo tee /usr/local/bin/health.sh >/dev/null <<'EOF'
#!/bin/bash
echo "== health report $(date) =="
df -h /
free -h
systemctl --failed --no-legend
EOF
```{{exec}}

```bash
sudo chmod +x /usr/local/bin/health.sh
```{{exec}}

The service (oneshot — it runs and exits):

```bash
sudo tee /etc/systemd/system/health.service >/dev/null <<'EOF'
[Unit]
Description=System health report
[Service]
Type=oneshot
ExecStart=/usr/local/bin/health.sh
EOF
```{{exec}}

The timer — every 15 minutes, catching up after downtime. **The `[Install]` lives on the timer**, not the
service:

```bash
sudo tee /etc/systemd/system/health.timer >/dev/null <<'EOF'
[Unit]
Description=Run health report every 15 min
[Timer]
OnCalendar=*:0/15
Persistent=true
[Install]
WantedBy=timers.target
EOF
```{{exec}}

Reload, then enable **and** start the timer in one go:

```bash
sudo systemctl daemon-reload
```{{exec}}

```bash
sudo systemctl enable --now health.timer
```{{exec}}

Confirm it's scheduled, then force one run now and read what it wrote — captured in the journal for free:

```bash
systemctl list-timers --no-pager | grep health
```{{exec}}

```bash
sudo systemctl start health.service
```{{exec}}

```bash
journalctl -u health.service --no-pager | tail -20
```{{exec}}

Your program now runs every quarter hour, forever, without you — and every run is queryable by unit and
time. Click **Check** to verify the script, both units, and the enabled timer.

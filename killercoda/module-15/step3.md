# Step 3 — Put a job on a schedule (cron)

Write a small script, **test it by hand first**, then arm the schedule. The module's law: *test the
service before you arm the timer* — the scheduler runs it in a bare context, so absolute paths matter.

Create the script — `set -euo pipefail` (M5), an absolute log path, an append that is its own evidence:

```bash
cat > ~/automation-lab/heartbeat.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
log="$HOME/automation-lab/heartbeat.log"
printf '%s heartbeat ok\n' "$(date -u +%FT%TZ)" >> "$log"
EOF
chmod +x ~/automation-lab/heartbeat.sh
```{{exec}}

**Manual test first** — never arm an untested job:

```bash
~/automation-lab/heartbeat.sh
```{{exec}}

```bash
cat ~/automation-lab/heartbeat.log
```{{exec}}

One line proves the action works. Now **arm it** — append a cron entry (every minute) without an editor.
Note the **absolute path**: cron's `PATH` is not your shell's, a classic works-manually-fails-on-timer
trap:

```bash
( crontab -l 2>/dev/null; echo "* * * * * $HOME/automation-lab/heartbeat.sh" ) | crontab -
```{{exec}}

```bash
crontab -l
```{{exec}}

Optionally watch cron fire on its own — the log grows without you, which *is* the evidence organ:

```bash
sleep 65 && cat ~/automation-lab/heartbeat.log
```{{exec}}

Click **Check** to verify a cron entry for the script exists and it produced output.

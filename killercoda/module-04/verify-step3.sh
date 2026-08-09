#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the health script + both units exist and the timer is enabled.
script="/usr/local/bin/health.sh"
svc="/etc/systemd/system/health.service"
tmr="/etc/systemd/system/health.timer"

[ -f "$script" ] || { echo "Missing $script — create it in Step 3 with the tee heredoc."; exit 1; }
[ -x "$script" ] || { echo "$script exists but is not executable — run: sudo chmod +x $script"; exit 1; }
[ -f "$svc" ] || { echo "Missing $svc — create the health.service unit."; exit 1; }
[ -f "$tmr" ] || { echo "Missing $tmr — create the health.timer unit."; exit 1; }

grep -q '^ExecStart=/usr/local/bin/health.sh' "$svc" || { echo "$svc has no ExecStart=/usr/local/bin/health.sh line."; exit 1; }
grep -q '^OnCalendar=' "$tmr" || { echo "$tmr is missing an OnCalendar= line."; exit 1; }
grep -q 'WantedBy=timers.target' "$tmr" || { echo "$tmr must have [Install] WantedBy=timers.target (the timer, not the service, faces boot)."; exit 1; }

if command -v systemctl >/dev/null 2>&1; then
  if ! systemctl is-enabled health.timer >/dev/null 2>&1; then
    echo "health.timer is not enabled — run: sudo systemctl daemon-reload && sudo systemctl enable --now health.timer"
    exit 1
  fi
fi

echo "Verified: health.sh is executable, health.service + health.timer exist, and the timer is enabled. The report now runs itself."
exit 0

#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the sleep process is gone.
if pgrep -f "sleep 300" >/dev/null 2>&1; then
  echo "The 'sleep 300' process is still running — terminate it with: pkill -f \"sleep 300\""
  exit 1
fi
echo "Verified: no 'sleep 300' process — the kernel reclaimed it."
exit 0

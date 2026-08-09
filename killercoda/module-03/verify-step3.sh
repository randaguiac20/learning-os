#!/bin/bash
# Killercoda step verifier: pass (exit 0) when secret.md is mode 640 and trap/ has the sticky bit.
lab="$HOME/learning/labs/m3"
[ -d "$lab" ] || { echo "Sandbox not found — create it with: mkdir -p ~/learning/labs/m3"; exit 1; }

secret="$lab/secret.md"
[ -f "$secret" ] || { echo "secret.md not found — create it with: touch secret.md (inside the sandbox)"; exit 1; }
mode=$(stat -c '%a' "$secret")
if [ "$mode" != "640" ]; then
  echo "secret.md is mode $mode, expected 640 — set it with: chmod 640 secret.md"
  exit 1
fi

trap="$lab/trap"
[ -d "$trap" ] || { echo "Directory 'trap' not found — create it with: mkdir trap && chmod 1770 trap"; exit 1; }
if [ ! -k "$trap" ]; then
  echo "'trap' has no sticky bit — add it with: chmod 1770 trap  (the trailing t protects entries)"
  exit 1
fi

echo "Verified: secret.md is 640 and trap/ carries the sticky bit. Permission model landed."
exit 0

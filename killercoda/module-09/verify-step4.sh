#!/bin/bash
# Killercoda step verifier: pass (exit 0) when ~/.ssh/config aliases the host and the alias logs in by key.
cfg="$HOME/.ssh/config"
[ -f "$cfg" ] || { echo "$cfg not found — add a Host block (Step 4)."; exit 1; }
grep -qiE '^[[:space:]]*Host[[:space:]]+mybox([[:space:]]|$)' "$cfg" || { echo "No 'Host mybox' block in ~/.ssh/config — add it (Step 4)."; exit 1; }
grep -qiE '^[[:space:]]*HostName[[:space:]]' "$cfg" || { echo "The Host block needs a HostName line (Step 4)."; exit 1; }
grep -qiE '^[[:space:]]*IdentityFile[[:space:]]' "$cfg" || { echo "The Host block needs an IdentityFile line (Step 4)."; exit 1; }
if ! ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -o ConnectTimeout=5 mybox true 2>/dev/null; then
  echo "'ssh mybox' did not log in by key — check HostName/User/IdentityFile in the block (Step 4)."
  exit 1
fi
echo "Verified: ~/.ssh/config aliases 'mybox' and the bare alias logs in with your key. Config works."
exit 0

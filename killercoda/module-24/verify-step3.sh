#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the secret file is locked down (0600, root-owned)
# and the SUID surprise has had its setuid bit stripped.
secret="/opt/app/config.env"
tool="/opt/app/backup-tool"

[ -f "$secret" ] || { echo "$secret not found — recreate it in Step 3, then fix its mode."; exit 1; }

mode=$(stat -c '%a' "$secret")
if [ "$mode" != "600" ]; then
  echo "$secret mode is $mode, expected 600 — run: sudo chmod 0600 $secret"
  exit 1
fi

owner=$(stat -c '%U' "$secret")
if [ "$owner" != "root" ]; then
  echo "$secret is owned by '$owner', expected root — run: sudo chown root:root $secret"
  exit 1
fi

# World must have no read or write on the secret (belt-and-suspenders on the mode check).
if [ -r "$secret" ] && [ "$(id -u)" != "0" ] && [ "$owner" != "$(id -un)" ]; then
  echo "$secret is still readable by others — lock it to owner-only with: sudo chmod 0600 $secret"
  exit 1
fi

if [ -e "$tool" ]; then
  if [ -u "$tool" ]; then
    echo "$tool still has the SUID bit — strip it with: sudo chmod u-s $tool"
    exit 1
  fi
fi

echo "Verified: $secret is 0600 root-owned, and the SUID bit on $tool is gone. Least privilege on the bits — nicely done."
exit 0

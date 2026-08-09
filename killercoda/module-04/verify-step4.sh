#!/bin/bash
# Killercoda step verifier: pass (exit 0) when /srv/data is a live ext4 mount with a matching UUID fstab entry.
mp="/srv/data"

[ -d "$mp" ] || { echo "Mount point $mp does not exist — run: sudo mkdir -p $mp"; exit 1; }

if command -v mountpoint >/dev/null 2>&1; then
  mountpoint -q "$mp" || { echo "$mp is not mounted — mount your loopback device: sudo mount -a (after adding the fstab line)."; exit 1; }
else
  grep -q " $mp " /proc/mounts || { echo "$mp is not mounted — mount your loopback device."; exit 1; }
fi

fstype=$(findmnt -n -o FSTYPE "$mp" 2>/dev/null)
[ "$fstype" = "ext4" ] || { echo "$mp is mounted but not ext4 (found '${fstype:-unknown}') — mkfs.ext4 the device."; exit 1; }

grep -Eq "^UUID=[^[:space:]]+[[:space:]]+$mp[[:space:]]+ext4" /etc/fstab || {
  echo "No UUID-based fstab entry for $mp — add: UUID=<uuid> $mp ext4 defaults,nofail 0 2 (never a /dev name)."
  exit 1
}

echo "Verified: $mp is a live ext4 mount and /etc/fstab persists it by UUID. Storage stack complete."
exit 0

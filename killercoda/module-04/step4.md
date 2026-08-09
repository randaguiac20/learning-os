# Step 4 — Build a persistent storage mount

Storage is a **stack**: device → partition → filesystem → mount → fstab. Each layer has its own tool.
Real disks are precious, so we practice on a throwaway **loopback file** — the same commands, zero risk to
the real disks.

Create a 128 MB file and attach it as a block device:

```bash
sudo fallocate -l 128M /var/tmp/disk.img
```{{exec}}

```bash
LOOP=$(sudo losetup --find --show /var/tmp/disk.img); echo "Attached as $LOOP"
```{{exec}}

Confirm the device exists (in real life you `lsblk` and **triple-check** before any format):

```bash
lsblk "$LOOP"
```{{exec}}

Write an **ext4 filesystem** onto it — read the output: inodes, superblocks (M3's words, made real):

```bash
sudo mkfs.ext4 "$LOOP"
```{{exec}}

Make a mount point and **mount** it, then prove it's there:

```bash
sudo mkdir -p /srv/data
```{{exec}}

```bash
sudo mount "$LOOP" /srv/data
```{{exec}}

```bash
df -h /srv/data
```{{exec}}

Now **persist** it. Grab the UUID (never a device name — those reorder) and write an fstab line with
`nofail`, then test it **without rebooting**:

```bash
UUID=$(sudo blkid -s UUID -o value "$LOOP"); echo "UUID=$UUID"
```{{exec}}

```bash
echo "UUID=$UUID /srv/data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
```{{exec}}

```bash
sudo umount /srv/data && sudo mount -a && findmnt /srv/data
```{{exec}}

`sudo mount -a` is **the professional test** — it applies fstab now, so a typo surfaces while you're
logged in instead of dropping the machine to emergency mode at boot. Click **Check** to verify `/srv/data`
is a live ext4 mount with a matching fstab entry.

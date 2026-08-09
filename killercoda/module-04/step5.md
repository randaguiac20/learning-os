# Step 5 — Backup with a restore drill

A backup you've never restored is a hope, not a backup. You'll archive with **tar**, sync with **rsync**,
then **prove** the backup by restoring a file you deleted.

Make some data to protect on your new mount:

```bash
sudo mkdir -p /srv/data/site && echo "important config v1" | sudo tee /srv/data/site/app.conf
```{{exec}}

**tar** — archive and compress. The golden habit: **inspect before you extract** (`-tvf`), never trust an
archive blind:

```bash
sudo tar -czf /var/tmp/site.tgz -C /srv/data site
```{{exec}}

```bash
tar -tvf /var/tmp/site.tgz
```{{exec}}

**rsync** — efficient sync. Always rehearse with `--dry-run` (`-n`) first, then run it for real into a
timestamped generation:

```bash
sudo mkdir -p /srv/backup
```{{exec}}

```bash
sudo rsync -avn /srv/data/site/ /srv/backup/$(date +%F)/
```{{exec}}

```bash
sudo rsync -av /srv/data/site/ /srv/backup/$(date +%F)/
```{{exec}}

Run rsync **again** and read the stats — the second run moves almost nothing, because rsync sends only
changed blocks (delta transfer):

```bash
sudo rsync -av --stats /srv/data/site/ /srv/backup/$(date +%F)/ | tail -15
```{{exec}}

### The restore drill — this is what makes it a backup

Simulate a loss, then restore only the lost file and prove it's identical:

```bash
sudo rm /srv/data/site/app.conf && ls /srv/data/site
```{{exec}}

```bash
sudo rsync -av /srv/backup/$(date +%F)/app.conf /srv/data/site/
```{{exec}}

```bash
diff <(echo "important config v1") /srv/data/site/app.conf && echo "RESTORE VERIFIED — identical"
```{{exec}}

A `diff`-clean restore is the moment the backup becomes real. You've now supervised a program, scheduled
it, given it durable storage, and protected that storage with a tested backup — the whole operator's loop
in one session.

# Step 3 — Fix the leak — permissions and a SUID surprise

The previous admin left two holes. First **reproduce the found state** (so the fix is real), then
harden it the right way — `ls -l` before and after, always.

Create the insecure artifacts an audit would find:

```bash
sudo mkdir -p /opt/app
echo 'API_TOKEN=sk-live-DEADBEEF' | sudo tee /opt/app/config.env
```{{exec}}

```bash
sudo chmod 0666 /opt/app/config.env
```{{exec}}

```bash
sudo cp /bin/bash /opt/app/backup-tool && sudo chmod 4755 /opt/app/backup-tool
```{{exec}}

**See the problem before you fix it:**

```bash
ls -l /opt/app
```{{exec}}

`config.env` is `-rw-rw-rw-` (**world-writable** — any local user rewrites your secret: integrity gone,
and world-**readable**: confidentiality gone). `backup-tool` shows an `s` in the owner slot
(`-rwsr-xr-x`) — **SUID-root**: it runs as root no matter who launches it, "root by another door."

Now harden — least privilege on the bits:

```bash
sudo chown root:root /opt/app/config.env && sudo chmod 0600 /opt/app/config.env
```{{exec}}

```bash
sudo chmod u-s /opt/app/backup-tool
```{{exec}}

**Verify the fix** — `config.env` is now `-rw-------` and `backup-tool` has no `s`:

```bash
ls -l /opt/app
```{{exec}}

Click **Check** to verify the secret is `0600` root-owned and the SUID bit is gone.

# Step 1 — FHS layout and file identity (inodes)

The **Filesystem Hierarchy Standard** is why Linux skills transfer between distros. Visit the key
directories and notice each one's owner and mode:

```bash
ls -ld /etc /var/log /usr/bin /usr/local/bin /tmp /home
```{{exec}}

`/tmp` shows a trailing `t` (`drwxrwxrwt`, mode `1777`) — world-writable *but* sticky, so only an entry's
owner may delete it. `/etc` holds host config; `/var/log` holds logs; `/usr/bin` holds package-installed
binaries; `/usr/local/bin` is for software *you* build.

```bash
cat /etc/hostname
```{{exec}}

Now build your sandbox — **all** mutating work in this lab lives here:

```bash
mkdir -p ~/learning/labs/m3 && cd ~/learning/labs/m3
```{{exec}}

A filename is **not** the file. The **inode** is the file (metadata + data-block pointers); a name just
points at an inode number. Prove it:

```bash
echo data > original
```{{exec}}

```bash
ls -i original
```{{exec}}

`stat` reads the whole inode aloud — owner, mode, link count, and the three timestamps:

```bash
stat original
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- What is the inode number of `original`? (You'll watch it get a second name in Step 2.)
- What is the link count right now? (It should be `1` — one name points at this inode.)

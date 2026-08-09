# Step 2 — Links: hard vs symbolic

Still in `~/learning/labs/m3`. A **hard link** is a second *name* for the same inode. A **symlink** is a
tiny separate file holding a *path*.

Make a hard link and confirm both names share one inode:

```bash
cd ~/learning/labs/m3
```{{exec}}

```bash
ln original hardlink
```{{exec}}

```bash
ls -li original hardlink
```{{exec}}

Same inode number, and the link count is now **2**. Now remove one name — the data survives, because the
inode still has a name pointing at it:

```bash
rm original
```{{exec}}

```bash
cat hardlink
```{{exec}}

`rm` removed a *label*, not the file. Now a **symlink**, which behaves differently:

```bash
ln -s hardlink softlink
```{{exec}}

```bash
ls -l
```{{exec}}

See the arrow (`softlink -> hardlink`). Remove the target and the symlink **dangles** — it points at a
path that no longer exists:

```bash
rm hardlink
```{{exec}}

```bash
cat softlink
```{{exec}}

That "No such file or directory" is the dangling symlink. Heal it by recreating the target:

```bash
echo data > hardlink
```{{exec}}

```bash
cat softlink
```{{exec}}

> Hard link = another name for the same inode (data survives either name's deletion). Symlink = a
> pointer file holding a path (can dangle, can cross filesystems, can point at directories).

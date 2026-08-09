# Step 3 — Permissions and the directory surprise

Access in Linux is **identity × mode bits**, evaluated **first-match** (owner, else group, else other).
Work in your sandbox and predict every `ls -l` line *before* you run the `chmod`.

```bash
cd ~/learning/labs/m3
```{{exec}}

```bash
touch secret.md
```{{exec}}

Set owner read+write, group read, others nothing — octal **640**:

```bash
chmod 640 secret.md
```{{exec}}

```bash
ls -l secret.md
```{{exec}}

Say it aloud: `rw-r-----` = 640. Octal and symbolic are two notations for the same nine bits.

**Now the directory surprise.** Directory `r` lists names, `x` traverses/enters, and `w` creates or
deletes entries. Watch what happens when a directory loses `x`:

```bash
mkdir vault && touch vault/gem
```{{exec}}

```bash
chmod 100 vault
```{{exec}}

```bash
cat vault/gem
```{{exec}}

```bash
ls vault
```{{exec}}

`cat vault/gem` works (you have `x` to traverse to a name you already know) but `ls vault` fails (you
lack `r` to list names). Restore it:

```bash
chmod 700 vault
```{{exec}}

Directory `w` is **deletion power** — the right to remove entries you don't even own. The fix is the
**sticky bit**, exactly what `/tmp` uses. Build a shared-but-safe directory:

```bash
mkdir trap && chmod 1770 trap
```{{exec}}

```bash
ls -ld trap
```{{exec}}

The trailing `t` (`drwxrwx--T`) is the sticky bit: group members share the directory, but only an
entry's owner may delete it.

Click **Check** to verify `secret.md` is mode 640 and `trap` has the sticky bit set.

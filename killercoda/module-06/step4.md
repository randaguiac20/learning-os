# Step 4 — Ex power: `:global` and `:substitute`

The `:` command-line operates on **ranges** — the line-editor DNA that makes file-wide edits
one-liners. `:g` (global) runs a command on every matching line and is literally `grep`'s ancestor —
read the name: **g/re/p**.

Create the starter file:

```bash
cd ~/vim-lab && [ -f hosts.txt ] || printf '# production hosts\nweb1\n# staging hosts\nweb2\ndb1\n' > hosts.txt; cat hosts.txt
```{{exec}}

Open it in Vim:

```bash
vim hosts.txt
```{{exec}}

**Your task — two Ex commands, then save:**

1. Delete every comment line (those starting with `#`) with `:global`:
   ```
   :g/^#/d
   ```
2. Rename the host `db1` to `db-primary` with `:substitute` across the file (word-boundaries `\<...\>`
   keep it exact):
   ```
   :%s/\<db1\>/db-primary/g
   ```

The file should end up as exactly these three lines:

```text
web1
web2
db-primary
```

Save and quit:

```
:wq
```

Reopen with `vim hosts.txt` to fix anything (`u` undoes). Then click **Check**.

> Bonus to try on a copy: `:v/web/d` deletes every line that does **not** match `web` — `:v` (aka
> `:g!`) is the inverse of `:g`.

# Step 4 — Software lifecycle with apt

Packages are the **only** sane way software enters a system. This step uses your first `sudo` — read
each command aloud and say what it touches before you run it.

First refresh the repo **metadata** (the signature check happens here — this is the software trust
chain):

```bash
sudo apt update
```{{exec}}

**Never install blind.** Investigate *before* installing — dependencies, size, origin, and which repo
you'd pull from:

```bash
apt show tree
```{{exec}}

```bash
apt policy tree
```{{exec}}

Now install it, then inventory exactly what landed on disk — note how the paths are FHS-shaped:

```bash
sudo apt install -y tree
```{{exec}}

```bash
dpkg -L tree
```{{exec}}

Use it once, meaningfully — on your own sandbox:

```bash
tree ~/learning
```{{exec}}

Which package owns a given file? `dpkg -S` is the reverse of `dpkg -L`:

```bash
dpkg -S "$(command -v tree)"
```{{exec}}

Click **Check** to verify `tree` is installed and inventoried.

> After the check: to remove it leaving **zero trace**, run `sudo apt purge -y tree`. `remove` alone
> would keep config files (dpkg state `rc`); `purge` deletes them too. Always read an `apt` prompt
> before confirming — never blind-confirm an `autoremove` list.

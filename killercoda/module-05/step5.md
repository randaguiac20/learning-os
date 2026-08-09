# Step 5 — Traps, cleanup, and shellcheck

Cleanup-at-the-end is a lie: the end may never come (an error, a `-e` abort, or Ctrl-C). A **trap** on
`EXIT` runs on *every* exit path. Prove it with a temp dir from `mktemp -d`:

```bash
cd ~/learning/scripts
```{{exec}}

```bash
cat > work.sh <<'EOF'
#!/bin/bash
set -euo pipefail
tmpdir="$(mktemp -d)"
trap 'echo "cleaning up $tmpdir" >&2; rm -rf "$tmpdir"' EXIT
echo "working in $tmpdir"
echo hello > "$tmpdir/data"
ls -l "$tmpdir"
EOF
chmod +x work.sh
```{{exec}}

Count the temp dirs before and after — the trap leaves no litter even though the script made one:

```bash
ls -d /tmp/tmp.* 2>/dev/null | wc -l
```{{exec}}

```bash
./work.sh
```{{exec}}

```bash
ls -d /tmp/tmp.* 2>/dev/null | wc -l
```{{exec}}

Now the debugging trio, in the order that catches the most for the least effort — parse, then static
lint, then dynamic trace:

```bash
bash -n backup-lite.sh && echo "parse OK"
```{{exec}}

```bash
command -v shellcheck >/dev/null 2>&1 || sudo apt-get install -y shellcheck
```{{exec}}

```bash
shellcheck ~/learning/scripts/*.sh || echo "read each SCxxxx wiki link — they are micro-lessons"
```{{exec}}

```bash
bash -x argshow.sh a "b c"
```{{exec}}

`bash -n` (parse only) → `shellcheck` (static, even branches you didn't run) → `bash -x` (trace the
path actually taken). Fix every finding or justify a one-line `# shellcheck disable=SCxxxx`. Your
scripts are now programs you can trust to run unattended.

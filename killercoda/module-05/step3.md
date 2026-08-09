# Step 3 — Exit codes, conditionals, and set -euo pipefail

Every command reports success (`0`) or failure (`1`–`255`) in `$?`. That code is the **API** between
your script and everything else. See it directly:

```bash
grep -q root /etc/passwd; echo "found root -> $?"
```{{exec}}

```bash
grep -q nobody-xyz /etc/passwd; echo "missing -> $?"
```{{exec}}

Now write a script that **branches** on an exit code and fails honestly — errors to stderr, non-zero
exit. Note the first two lines every script gets: the shebang and the seatbelt:

```bash
cd ~/learning/scripts
```{{exec}}

```bash
cat > check-user.sh <<'EOF'
#!/bin/bash
set -euo pipefail
name="${1:?usage: $0 <username>}"
if grep -q "^$name:" /etc/passwd; then
  echo "exists: $name"
else
  echo "missing: $name" >&2
  exit 1
fi
EOF
chmod +x check-user.sh
```{{exec}}

Prove the exit code drives `&&` and `||`:

```bash
./check-user.sh root && echo "the && ran because exit was 0"
```{{exec}}

```bash
./check-user.sh nobodyxyz || echo "the || ran because exit was $?"
```{{exec}}

`set -euo pipefail` is the seatbelt: `-e` aborts on an unchecked failure, `-u` makes an **unset**
variable fatal (the Steam-bug typo catcher), `pipefail` makes a pipe fail if any member fails. Watch
`-u` catch a typo:

```bash
bash -c 'set -u; echo "value is $undefined_var"' ; echo "exit was $?"
```{{exec}}

Click **Check** to verify `check-user.sh` exists, starts with the shebang + set line, and reports its
exit code honestly.

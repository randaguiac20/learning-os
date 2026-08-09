# Step 2 — Read the error, read the exit code

A teammate left you a small reporting tool. Create it and its config exactly as shipped:

```bash
cat > ~/debug-lab/report.sh <<'EOF'
#!/bin/bash
set -euo pipefail
config="$HOME/debug-lab/etc/report.conf"
threshold=$(grep '^threshold=' "$config" | cut -d= -f2)
echo "Report OK — threshold=$threshold"
EOF
chmod +x ~/debug-lab/report.sh
```{{exec}}

```bash
printf 'threshold=42\n' > ~/debug-lab/report.conf
```{{exec}}

Run it — and **read the output and the exit code before forming any theory**:

```bash
~/debug-lab/report.sh; echo "exit=$?"
```{{exec}}

It fails. The message names a file, and `exit=` is non-zero. Now look at what's actually on disk:

```bash
ls -l ~/debug-lab
```{{exec}}

There **is** a `report.conf` — yet the program says *No such file or directory*. That contradiction is the
whole puzzle. **Quit thinking and look:** don't assume the config is malformed or the parser is broken.
The next step uses `strace` to see the *exact* path the program tried to open — the truth the error
message only hints at.

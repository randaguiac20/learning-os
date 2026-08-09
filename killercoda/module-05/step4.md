# Step 4 — Functions, args, and getopts

Functions turn 100 lines of soup into readable units with their own `local` state and exit status.
First, a drill on positional arguments — `$#` (count), `"$@"` (each arg intact):

```bash
cd ~/learning/scripts
```{{exec}}

```bash
cat > argshow.sh <<'EOF'
#!/bin/bash
set -euo pipefail
usage() { echo "usage: $0 arg..." >&2; exit 2; }
show() { local a; echo "count=$#"; for a in "$@"; do echo "[$a]"; done; }
main() { [[ $# -gt 0 ]] || usage; show "$@"; }
main "$@"
EOF
chmod +x argshow.sh
```{{exec}}

Predict the output **before** running — `"b c"` should stay one `[b c]`:

```bash
./argshow.sh a "b c" d
```{{exec}}

`usage()` writes to **stderr** and exits `2`; `local a` scopes the loop variable; `"$@"` preserved
`b c` as one argument. Now parse flags like a real tool with `getopts` — the `:` after a letter means
"takes a value" (it lands in `$OPTARG`):

```bash
cat > backup-lite.sh <<'EOF'
#!/bin/bash
set -euo pipefail
usage() { echo "usage: $0 -d dest [-n] [-g N] [-h]" >&2; exit 2; }
main() {
  local dest="" dry="real" gens=3 opt
  while getopts "d:ng:h" opt; do
    case "$opt" in
      d) dest="$OPTARG" ;;
      n) dry="dry-run" ;;
      g) gens="$OPTARG" ;;
      h) usage ;;
      *) usage ;;
    esac
  done
  [[ -n "$dest" ]] || usage
  echo "mode=$dry keep=$gens dest=${dest:?}"
}
main "$@"
EOF
chmod +x backup-lite.sh
```{{exec}}

Run the failure path (missing required `-d`) and the happy path:

```bash
./backup-lite.sh -n || echo "refused: missing -d, exit $?"
```{{exec}}

```bash
./backup-lite.sh -d /tmp/backup -n -g 5
```{{exec}}

Click **Check** to verify `backup-lite.sh` parses flags, requires `-d`, and uses `main "$@"`.

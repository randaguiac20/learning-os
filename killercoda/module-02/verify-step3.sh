#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the sandbox tree and first file exist.
lab="$HOME/terminal-lab"
[ -d "$lab" ] || { echo "Sandbox not found — create it with: mkdir ~/terminal-lab"; exit 1; }
for d in projects/alpha/notes projects/beta/notes; do
  [ -d "$lab/$d" ] || { echo "Missing directory '$d' — build the tree with: mkdir -p projects/{alpha,beta}/notes"; exit 1; }
done
[ -f "$lab/projects/alpha/notes/day1.md" ] || { echo "day1.md not found — create it with: touch projects/alpha/notes/day1.md"; exit 1; }
echo "Verified: ~/terminal-lab holds the projects/{alpha,beta}/notes tree and day1.md. Nicely done."
exit 0

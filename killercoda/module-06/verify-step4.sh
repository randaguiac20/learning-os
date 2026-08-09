#!/bin/bash
# Killercoda step verifier: pass (exit 0) when :g deleted the comment lines and :s renamed the host.
f="$HOME/vim-lab/hosts.txt"
[ -f "$f" ] || { echo "hosts.txt not found — create it in ~/vim-lab and edit it as shown in Step 4."; exit 1; }

if grep -q '^#' "$f"; then
  echo "Comment lines (starting with #) are still present — delete them with:  :g/^#/d"
  exit 1
fi
grep -q '^web1$' "$f"       || { echo "Expected 'web1' to remain — did :g delete too much? Reopen and retry."; exit 1; }
grep -q '^web2$' "$f"       || { echo "Expected 'web2' to remain — did :g delete too much? Reopen and retry."; exit 1; }
grep -q '^db-primary$' "$f" || { echo "Expected 'db-primary' — rename it with:  :%s/\\<db1\\>/db-primary/g"; exit 1; }
grep -q '^db1$' "$f"        && { echo "'db1' is still there — substitute it with:  :%s/\\<db1\\>/db-primary/g"; exit 1; }

lines=$(grep -c . "$f")
[ "$lines" = "3" ] || { echo "Expected exactly 3 non-empty lines (web1, web2, db-primary); found $lines. Check your :g range."; exit 1; }

echo "Verified: :g/^#/d removed the comments and :%s renamed db1 -> db-primary. Ex power confirmed."
exit 0

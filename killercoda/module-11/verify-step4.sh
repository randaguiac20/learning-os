#!/bin/bash
# Killercoda step verifier: pass (exit 0) when settings.json is valid JSON, allowlist non-empty, no Bash(*).
proj="$HOME/claude-lab"
s="$proj/.claude/settings.json"
[ -f "$s" ] || { echo "$s not found — author it in Step 4."; exit 1; }
python3 -m json.tool "$s" >/dev/null 2>&1 || { echo "$s is not valid JSON — fix it (a broken settings file is silently ignored)."; exit 1; }
n=$(python3 -c 'import json,sys; d=json.load(open(sys.argv[1])); print(len(d.get("permissions",{}).get("allow",[])))' "$s" 2>/dev/null)
[ "${n:-0}" -ge 1 ] || { echo "permissions.allow is empty — add narrow entries like Bash(shellcheck:*) (Step 4)."; exit 1; }
if grep -qE 'Bash\(\*\)' "$s"; then echo "Found Bash(*) — remove the blanket grant; it defeats the whole gate (Step 4)."; exit 1; fi
echo "Verified: settings.json is valid JSON, the allowlist is narrow and non-empty, and Bash(*) is absent."
exit 0

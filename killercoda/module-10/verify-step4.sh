#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the demo project pins a Python runtime via mise.
proj="$HOME/dotfiles-lab/mise-demo"
cfg="$proj/mise.toml"
[ -f "$cfg" ] || { echo "$cfg not found — create the project and write mise.toml (Step 4)."; exit 1; }
grep -qE '^[[:space:]]*python[[:space:]]*=' "$cfg" || { echo "mise.toml does not pin a python version — add e.g. python = \"3.11\" under [tools] (Step 4)."; exit 1; }
echo "Verified: $cfg pins a Python runtime — the per-directory reproducibility contract is in place."
exit 0

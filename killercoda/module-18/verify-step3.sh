#!/bin/bash
# Killercoda step verifier: pass (exit 0) when .devcontainer holds a Dockerfile and a valid
# devcontainer.json carrying the required keys and a non-root remoteUser.
repo="$HOME/hello-bench"
dc="$repo/.devcontainer"
spec="$dc/devcontainer.json"

[ -f "$dc/Dockerfile" ] || { echo "Missing $dc/Dockerfile — write it in Step 2."; exit 1; }
[ -f "$spec" ] || { echo "Missing $spec — write it in Step 3."; exit 1; }

if ! python3 -m json.tool "$spec" >/dev/null 2>&1; then
  echo "devcontainer.json is not valid strict JSON — check for trailing commas or // comments (json.tool is strict)."
  exit 1
fi

python3 - "$spec" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))
missing = [k for k in ("name", "remoteUser", "forwardPorts", "postCreateCommand") if k not in d]
if "image" not in d and "build" not in d:
    missing.append("image-or-build (a base)")
if missing:
    print("devcontainer.json is valid JSON but missing keys: " + ", ".join(missing))
    sys.exit(1)
if d.get("remoteUser") == "root":
    print("remoteUser is root — use a non-root user (the container-habit does not stop at the door).")
    sys.exit(1)
PY
[ $? -eq 0 ] || exit 1

echo "Verified: a Dockerfile plus a valid devcontainer.json (name, a base, non-root remoteUser, forwardPorts, postCreateCommand). The spec is the contract."
exit 0

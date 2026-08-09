#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the local HTTP server is listening and reachable.
if ! command -v ss >/dev/null 2>&1; then
  echo "ss not found — run the install command in Step 1 first."
  exit 1
fi
if ! ss -tln 2>/dev/null | grep -q ':8080'; then
  echo "No listener on :8080 — start it with: nohup python3 -m http.server 8080 >/tmp/http.log 2>&1 &"
  exit 1
fi
if ! curl -s -o /dev/null --max-time 5 http://127.0.0.1:8080/; then
  echo "Port :8080 is listening but not answering HTTP — check /tmp/http.log and that the server is still running."
  exit 1
fi
echo "Verified: a server is listening on :8080 and answering HTTP on loopback. Socket is live."
exit 0

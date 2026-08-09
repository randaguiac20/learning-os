#!/bin/bash
# Killercoda step verifier: pass when lab.local resolves to loopback AND the request through it succeeds.
if ! getent hosts lab.local | grep -q '127.0.0.1'; then
  echo "lab.local does not resolve to 127.0.0.1 — add it in Step 2 with: echo '127.0.0.1 lab.local' | sudo tee -a /etc/hosts"
  exit 1
fi
if ! curl -s -o /dev/null --max-time 5 http://lab.local:8080/; then
  echo "Request to http://lab.local:8080/ failed — is the Step 3 server still running? (ss -tlnp | grep 8080)"
  exit 1
fi
echo "Verified: lab.local resolves to 127.0.0.1 and the server answers through the name. Name -> address -> socket, end to end."
exit 0

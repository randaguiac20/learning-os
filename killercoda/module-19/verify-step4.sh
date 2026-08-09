#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the 'web' Service exists and has at least one ready endpoint.
if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl not found — this scenario ships a ready cluster; open a fresh terminal and retry."
  exit 1
fi
if ! kubectl get svc web >/dev/null 2>&1; then
  echo "Service 'web' not found — expose the Deployment (Step 4): kubectl expose deployment web --port=80 --target-port=8080 --name=web"
  exit 1
fi
eps=$(kubectl get endpoints web -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null | wc -w)
if [ "$eps" -lt 1 ]; then
  echo "Service 'web' has no ready endpoints yet — check the selector and pod readiness: kubectl get endpoints web ; kubectl get pods -l app=web"
  exit 1
fi
echo "Verified: Service 'web' exists and has ${eps} ready endpoint(s). readiness gated that membership — 'get endpoints' is the moment of truth."
exit 0

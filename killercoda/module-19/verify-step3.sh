#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the 'web' Deployment exists with 3 ready replicas.
if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl not found — this scenario ships a ready cluster; open a fresh terminal and retry."
  exit 1
fi
if ! kubectl get deployment web >/dev/null 2>&1; then
  echo "Deployment 'web' not found — write web.yaml (Step 3) and apply it: kubectl apply -f web.yaml"
  exit 1
fi
ready=$(kubectl get deployment web -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
ready=${ready:-0}
if [ "$ready" -lt 3 ]; then
  echo "Deployment 'web' has ${ready}/3 ready replicas — give the pods a few seconds to pull and start: kubectl rollout status deployment/web"
  exit 1
fi
echo "Verified: Deployment 'web' has 3 ready replicas. The controllers built the Deployment → ReplicaSet → Pods chain from your one object."
exit 0

#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the 'web' Deployment consumes the ConfigMap
# and Secret and has both a readiness and a liveness probe configured.
NS=k8s-ops

kubectl get namespace "$NS" >/dev/null 2>&1 || {
  echo "Namespace '$NS' not found — create it in Step 1: kubectl create namespace $NS"; exit 1; }

Y=$(kubectl -n "$NS" get deploy web -o yaml 2>/dev/null) || {
  echo "Deployment 'web' not found in $NS — apply the manifest in Step 3."; exit 1; }

echo "$Y" | grep -Eq 'configMapKeyRef|configMap:' || {
  echo "'web' does not consume a ConfigMap — inject web-config as an env var and/or a mounted volume."; exit 1; }

echo "$Y" | grep -Eq 'secretKeyRef|secretName' || {
  echo "'web' does not consume a Secret — inject web-secret as an env var and/or a mounted volume."; exit 1; }

echo "$Y" | grep -q 'readinessProbe' || {
  echo "No readinessProbe on 'web' — add one (httpGet / on port 80) as shown in Step 3."; exit 1; }

echo "$Y" | grep -q 'livenessProbe' || {
  echo "No livenessProbe on 'web' — add one (httpGet / on port 80) as shown in Step 3."; exit 1; }

echo "Verified: 'web' consumes web-config + web-secret and has readiness + liveness probes. Nicely done."
exit 0

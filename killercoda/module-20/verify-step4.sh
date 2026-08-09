#!/bin/bash
# Killercoda step verifier: pass (exit 0) when 'web' has more than one rollout revision
# (a rolling update happened) AND is healthy again (the rollback recovered it).
NS=k8s-ops

kubectl get namespace "$NS" >/dev/null 2>&1 || {
  echo "Namespace '$NS' not found — start from Step 1."; exit 1; }

kubectl -n "$NS" get deploy web >/dev/null 2>&1 || {
  echo "Deployment 'web' not found in $NS — start from Step 3."; exit 1; }

REV=$(kubectl -n "$NS" rollout history deploy web 2>/dev/null | grep -cE '^[0-9]+')
if [ "${REV:-0}" -lt 2 ]; then
  echo "Fewer than 2 rollout revisions — do a rolling update in Step 4 (kubectl set resources ...)."; exit 1
fi

AVAIL=$(kubectl -n "$NS" get deploy web -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
if [ "${AVAIL:-0}" -lt 1 ]; then
  echo "No available replicas — after the bad rollout, recover with: kubectl -n $NS rollout undo deploy/web"; exit 1
fi

echo "Verified: 'web' has $REV rollout revisions and $AVAIL available replica(s) — rolling update + rollback exercised."
exit 0

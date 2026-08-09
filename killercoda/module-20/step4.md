# Step 4 — A failing probe, a bad rollout, and a rollback

## Watch a failing liveness probe restart a container

A separate throwaway pod whose liveness probe **deliberately fails** after 30 s. It touches
`/tmp/healthy`, sleeps 30 s, then deletes the file — so `cat /tmp/healthy` starts failing and the
kubelet restarts the container:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata: { name: probe-demo, namespace: k8s-ops }
spec:
  containers:
  - name: app
    image: busybox:1.36
    args: ["/bin/sh","-c","touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600"]
    livenessProbe:
      exec: { command: ["cat","/tmp/healthy"] }
      initialDelaySeconds: 5
      periodSeconds: 5
EOF
```{{exec}}

Watch `RESTARTS` climb from 0 (wait ~40 s, then press **Ctrl-C** to stop watching):

```bash
kubectl get pod probe-demo -w
```{{exec}}

The failing probe is right there in the Events, then clean up:

```bash
kubectl describe pod probe-demo | grep -i -A2 liveness
```{{exec}}

```bash
kubectl delete pod probe-demo
```{{exec}}

Liveness **restarts**; readiness would only have pulled the pod from traffic. Different jobs.

## Ship a bad rolling update — and undo it

Now update the `web` Deployment to **request** an impossible amount of memory. The new pod can't be
scheduled, but the **old pods keep serving** — a rolling update never retires the old version until the
new one is Ready:

```bash
kubectl set resources deploy/web --requests=memory=100Gi --limits=memory=100Gi
```{{exec}}

The rollout will **not** finish (the `|| true` keeps the step from erroring on the expected timeout):

```bash
kubectl rollout status deploy/web --timeout=30s || true
```{{exec}}

The new pod is stuck **Pending** — a *request* no node can satisfy:

```bash
kubectl get pods
```{{exec}}

```bash
kubectl describe pod -l app=web | grep -i -m1 insufficient
```{{exec}}

Recover in **one command**, then read the revision ledger:

```bash
kubectl rollout undo deploy/web
```{{exec}}

```bash
kubectl rollout status deploy/web
```{{exec}}

```bash
kubectl rollout history deploy/web
```{{exec}}

Click **Check** to verify `web` has multiple rollout revisions and is healthy again after the rollback.

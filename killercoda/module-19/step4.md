# Step 4 — Expose it with a Service

Pods are cattle — they churn and their IPs change. A **Service** gives the set a stable name and a
virtual IP (a ClusterIP). Expose your Deployment:

```bash
kubectl expose deployment web --port=80 --target-port=8080 --name=web
```{{exec}}

A ClusterIP is assigned — but there is no "service machine" behind it, only DNAT rules on the node:

```bash
kubectl get svc web
```{{exec}}

Now the **moment-of-truth** command. A Service is only as real as its endpoints — the set of *ready* pods
that match its selector:

```bash
kubectl get endpoints web
```{{exec}}

You should see three pod IPs. Readiness gated that membership: fail readiness and a pod silently leaves
this list. Prove the whole chain works — CoreDNS resolves the name, kube-proxy DNATs to a ready endpoint:

```bash
kubectl run tmp --image=registry.k8s.io/e2e-test-images/agnhost:2.53 --rm -it --restart=Never \
  -- /bin/sh -c 'wget -qO- http://web/hostname; echo'
```{{exec}}

The pod name printed is the backend that answered — the name `web` resolved through CoreDNS to the
ClusterIP, and kube-proxy rewrote the packet to one ready pod. Run it again and you may hit a different
pod: load spreading is kernel packet-rewriting, not a middlebox.

Click **Check** to verify the Service exists and its endpoints are populated.

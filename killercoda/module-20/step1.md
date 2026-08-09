# Step 1 — Bearings and a scoped namespace

Before touching anything, three questions: *is the cluster up, who am I, and where will my work live?*

Is the node Ready?

```bash
kubectl get nodes -o wide
```{{exec}}

A **namespace** partitions one cluster into scopes. Create one for this whole lab, then make it your
default so you don't repeat `-n k8s-ops` every time:

```bash
kubectl create namespace k8s-ops
```{{exec}}

```bash
kubectl config set-context --current --namespace=k8s-ops
```{{exec}}

A quick **RBAC** self-check — RBAC decides who may do what. You're the cluster admin here, so this is
`yes`; later you'll build a ServiceAccount that gets a firm `no` until you grant it exactly what it needs:

```bash
kubectl auth can-i create deployments
```{{exec}}

Everything below runs **in `k8s-ops`**. When you're done, one command removes all of it — no cleanup by
hand.

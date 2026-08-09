# Step 1 — Meet the control plane

Before deploying anything, get your bearings: *where is the cluster, what runs it, what runs on it?*

Where is the front door (the apiserver), and how many nodes are there?

```bash
kubectl cluster-info
```{{exec}}

```bash
kubectl get nodes -o wide
```{{exec}}

Now meet the control plane itself. Kubernetes runs its **own** components as pods in the `kube-system`
namespace — the platform, hosting itself:

```bash
kubectl get pods -n kube-system
```{{exec}}

Read that list against the two-planes model and find each component's one job:

- **kube-apiserver** — THE only door: every read/write of every object goes through it.
- **etcd** — the state store: every object's source of truth.
- **kube-scheduler** — places pods on nodes (filter, then score).
- **kube-controller-manager** — the reconciliation loops (deployment, replicaset, node…).
- **coredns** — names Services inside the cluster.
- **kube-proxy** — programs Service routing on the node.

Confirm your client and the cluster are close in version (keep them within one minor release):

```bash
kubectl version
```{{exec}}

Everything else in this lab talks **through** that apiserver — there are no side channels. That is why a
single client, `kubectl`, can see and change everything.

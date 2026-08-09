# Done — you drove the model, not just kubectl

In about 30 minutes you:

- Met the **control plane** running as pods on the cluster — apiserver (the only door), etcd, scheduler,
  controller-manager, CoreDNS, kube-proxy — and saw that everything talks *through* the apiserver.
- Used **`kubectl explain`** as the built-in dictionary and wrote a **Deployment from scratch** — one
  object that the controllers expanded into a ReplicaSet and three Pods.
- Exposed a **Service**, read its **endpoints** (the moment-of-truth), and proved the CoreDNS → ClusterIP
  → kube-proxy DNAT chain by curling the name from another pod.
- **Scaled** the Deployment by changing the wish, and watched the Service membership follow automatically.
- Deleted a pod and watched the **reconcile loop** replace it — you deleted a *fact*, not the *wish* —
  then read the `ownerReferences` that make the chain concrete.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
When every box is honestly true, M20 (Kubernetes Operations) — which operates **this** cluster and
completes the stage project — becomes current.

> The one-sentence takeaway: **Kubernetes is desired state plus reconciliation — you declare objects in
> the API and controllers converge reality forever; the deleted pod that came back is the whole idea,
> proven.**

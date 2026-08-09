# Step 5 — Scale, then delete a pod and watch it heal

You never start pods — you change the **wish** and reconciliation converges. Change the desired count:

```bash
kubectl scale deployment web --replicas=5
```{{exec}}

Watch two new pods appear, then press **Ctrl-C** to stop watching:

```bash
kubectl get pods -l app=web -w
```{{exec}}

The Service membership grew automatically — you changed nothing about the Service:

```bash
kubectl get endpoints web
```{{exec}}

Now the **rite of passage**. Delete a pod and watch the controller replace it — because you deleted a
*fact*, not the *wish*. Note a pod name, delete it, then watch:

```bash
kubectl delete pod "$(kubectl get pod -l app=web -o jsonpath='{.items[0].metadata.name}')"
```{{exec}}

```bash
kubectl get pods -l app=web -w
```{{exec}}

A **new** pod appears within seconds (Ctrl-C when you've seen it). Nothing "restarted" it — the
ReplicaSet's loop saw `4 ≠ 5` and created one. That is level-triggered reconciliation, felt.

Finally, read what the controller actually wrote. A pod's real YAML shows its `ownerReferences` back up
the chain, plus its conditions and QoS:

```bash
kubectl get pod -l app=web -o yaml | grep -A5 ownerReferences | head -8
```{{exec}}

```bash
kubectl describe pod -l app=web | sed -n '1,25p'
```{{exec}}

That `ownerReferences` block is the loose coupling made concrete: the pod is **owned** by the ReplicaSet,
which is owned by the Deployment. Edit the top of that chain (the Deployment, in git) — never the pods a
controller owns, or your change gets reverted on the next loop.

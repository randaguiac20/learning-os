# Kubernetes Core — the model, on a real cluster

You have a **real single-node Kubernetes cluster** in the terminal on the right, with `kubectl` already
configured — no install, no waiting. In the next few minutes you'll meet the **control plane** (running
as pods on the cluster itself), deploy an app from a **handwritten manifest**, expose it with a
**Service** and read its endpoints, scale it, and finally delete a pod and watch the **reconcile loop**
replace it — the whole thesis of the module, proven with your own hands.

The one idea to carry the whole way: you **declare** the state you want (as objects in the API) and a
swarm of **controllers** works forever to make reality match. You never "start a pod" — you tell the
cluster there should BE three, and it keeps three.

> Tip: **type every command yourself** and read the output — `get`, `describe`, and `get endpoints` are
> the skill. The iron law of this module is *manifests written from scratch*, so build the YAML by hand.

Click **START** to begin.

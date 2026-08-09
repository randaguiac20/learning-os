# Kubernetes Operations — hands-on

You have a real **single-node Kubernetes cluster** on the right, with `kubectl` ready at the prompt.
Module 19 gave you a running Deployment; here you learn to **operate** one like you mean it.

In the next few minutes you'll:

- inject configuration as **data** — a **ConfigMap** and a **Secret**, as env vars *and* mounted files,
- add **health probes** and watch a deliberately failing liveness probe **restart** a pod,
- set **resource requests and limits** and read their failure signatures,
- ship a **rolling update** and undo it in **one command**.

**Everything is scoped to a throwaway `k8s-ops` namespace you create first** — one `kubectl delete
namespace k8s-ops` removes all of it, and nothing else on the cluster is touched.

> Tip: **type every command yourself** — don't copy-paste blindly. Reading each command before you run
> it is the operator's habit that prevents 3 a.m. accidents.

Click **START** to begin.

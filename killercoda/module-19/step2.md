# Step 2 — The API is the system

Every capability in Kubernetes is an **object** in the API. Before writing a manifest, meet the object
catalog and the built-in dictionary that makes copy-paste unnecessary.

List the kinds of object this cluster understands — each is something a controller reconciles:

```bash
kubectl api-resources | head -30
```{{exec}}

`kubectl explain` is the **first documentation stop** — the spec, straight from the apiserver. Read the
shape of a Deployment and drill into a field:

```bash
kubectl explain deployment
```{{exec}}

```bash
kubectl explain deployment.spec.template.spec.containers
```{{exec}}

See the whole cluster's workload objects at a glance (there are none of *yours* yet — you'll fix that
next):

```bash
kubectl get all
```{{exec}}

The pattern to internalize: you never memorize YAML from a blog. You ask the API what a field is with
`explain`, write the manifest yourself, and let the controllers do the rest. **The API is the system** —
`kubectl` is just one client of it.

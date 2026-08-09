# Step 2 — Config as data — ConfigMap and Secret

Configuration does **not** belong baked into an image. Externalise it so the same image runs anywhere
with different values. Non-secret config goes in a **ConfigMap**:

```bash
kubectl create configmap web-config \
  --from-literal=APP_GREETING='Hello from a ConfigMap' \
  --from-literal=app.conf='server_tokens off;'
```{{exec}}

Sensitive values go in a **Secret** — same shapes, different object:

```bash
kubectl create secret generic web-secret \
  --from-literal=API_TOKEN='s3cr3t-token'
```{{exec}}

Look at how each is stored. The ConfigMap keeps values in plain text:

```bash
kubectl get configmap web-config -o yaml
```{{exec}}

The Secret's values are **base64-encoded — NOT encrypted at rest** by default. Prove it by decoding:

```bash
kubectl get secret web-secret -o jsonpath='{.data.API_TOKEN}' | base64 -d; echo
```{{exec}}

That is why a Secret means "keep out of git," not "safe if the cluster leaks." Encryption at rest and
external secret stores are the production upgrade. Next you'll feed both into a pod.

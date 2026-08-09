# Step 3 — Deploy from a handwritten manifest

The iron law: **manifests written from scratch**. Write a minimal Deployment — three replicas of a small
HTTP test image — reading each field against `kubectl explain` as you go:

```bash
cat > web.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: registry.k8s.io/e2e-test-images/agnhost:2.53
          args: ["netexec", "--http-port=8080"]
          ports:
            - containerPort: 8080
EOF
```{{exec}}

Apply it — you are declaring desired state, not starting containers:

```bash
kubectl apply -f web.yaml
```{{exec}}

Watch the **ownership chain** the controllers built from your one object — Deployment → ReplicaSet →
Pods:

```bash
kubectl get deploy,rs,pods -l app=web
```{{exec}}

Give the pods a few seconds to pull the image and become Ready, then look again:

```bash
kubectl rollout status deployment/web
```{{exec}}

You created **one** object (the Deployment) and got a ReplicaSet and three Pods for free: the deployment
controller made the ReplicaSet, the replicaset controller made the Pods, the scheduler placed them, the
kubelet ran them. The apply trace, performed.

Click **Check** to verify the Deployment has 3 ready replicas.

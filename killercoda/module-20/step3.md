# Step 3 — A Deployment with config and health probes

Now a **Deployment** that consumes both objects — the ConfigMap and Secret as **env vars** *and* as
**mounted files** — with a **readiness** probe (gates traffic) and a **liveness** probe (self-heal),
plus **requests and limits**. Apply it:

```bash
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: k8s-ops
spec:
  replicas: 2
  selector: { matchLabels: { app: web } }
  template:
    metadata: { labels: { app: web } }
    spec:
      containers:
      - name: web
        image: nginx:1.25-alpine
        ports: [ { containerPort: 80 } ]
        env:
        - name: APP_GREETING
          valueFrom: { configMapKeyRef: { name: web-config, key: APP_GREETING } }
        - name: API_TOKEN
          valueFrom: { secretKeyRef: { name: web-secret, key: API_TOKEN } }
        volumeMounts:
        - { name: cfg, mountPath: /etc/web/config }
        - { name: sec, mountPath: /etc/web/secret, readOnly: true }
        readinessProbe:
          httpGet: { path: /, port: 80 }
          periodSeconds: 5
        livenessProbe:
          httpGet: { path: /, port: 80 }
          initialDelaySeconds: 5
          periodSeconds: 10
        resources:
          requests: { cpu: 50m, memory: 32Mi }
          limits:   { cpu: 200m, memory: 64Mi }
      volumes:
      - { name: cfg, configMap: { name: web-config } }
      - { name: sec, secret: { secretName: web-secret } }
EOF
```{{exec}}

Wait for the rollout to finish (readiness must pass before pods count as available):

```bash
kubectl rollout status deploy/web
```{{exec}}

Prove the **env** injection worked:

```bash
kubectl exec deploy/web -- printenv APP_GREETING API_TOKEN
```{{exec}}

And prove the **mounted files** are present (each ConfigMap/Secret key is a file):

```bash
kubectl exec deploy/web -- ls /etc/web/config /etc/web/secret
```{{exec}}

Click **Check** to verify the `web` Deployment consumes the ConfigMap and Secret and has both probes
configured.

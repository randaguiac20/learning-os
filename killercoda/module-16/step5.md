# Step 5 — Compose a 2-service rig

Real systems are several containers cooperating. **Compose** declares them in one file and wires a
user-defined network with **DNS**, so services reach each other **by name**.

Make sure the Compose plugin is present (installed in Step 1):

```bash
docker compose version || sudo apt-get install -y docker-compose-v2
```{{exec}}

Move to the lab dir and write a 2-service `compose.yaml` — a web service, and a `probe` that fetches it
**by the name `web`** (not an IP):

```bash
cd ~/docker-lab
```{{exec}}

```bash
cat > compose.yaml <<'YAML'
services:
  web:
    image: nginx:alpine
    ports:
      - "8082:80"
  probe:
    image: busybox
    command: sh -c "sleep 3 && wget -qO- http://web && sleep 3600"
YAML
```{{exec}}

Bring the whole rig up in the background:

```bash
docker compose up -d
```{{exec}}

```bash
docker compose ps
```{{exec}}

The `probe` service reached `web` **by name** — its logs show nginx's HTML, fetched via the embedded DNS
resolver at `127.0.0.11` on the network Compose created:

```bash
docker compose logs probe
```{{exec}}

And the web service answers on the host's published port too:

```bash
curl -s localhost:8082
```{{exec}}

Tear the rig down. `down` removes the containers and network; add `-v` **only** when you mean to delete
volumes too (a decision, not a habit):

```bash
docker compose down
```{{exec}}

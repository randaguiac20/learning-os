# Step 2 — Write the Dockerfile — non-root

Your base decision is `build` — a Dockerfile you own and review in-repo (deterministic, no third-party
trust). Write one with a **non-root** user, so files you create in a bind-mounted workspace aren't
root-owned wreckage on the host:

```bash
cat > ~/hello-bench/.devcontainer/Dockerfile <<'EOF'
FROM python:3.12-slim
# a non-root user so workspace files aren't root-owned on the host (the uid dance)
ARG USERNAME=dev
RUN useradd --create-home "$USERNAME"
USER $USERNAME
EOF
```{{exec}}

```bash
cat ~/hello-bench/.devcontainer/Dockerfile
```{{exec}}

Two deliberate choices:

- **`python:3.12-slim` is pinned** — never `latest`. Tags lie; a pinned base is the same base on Monday.
- **`USER dev`** — the container runs as a non-root user. This one line is why your workspace won't fill
  with root-owned files. (Real specs pair this with `remoteUser` + `updateRemoteUserUID` so the container
  uid is remapped to match yours.)

A dev container is still a container: the non-root habit from Docker does not stop at the door.

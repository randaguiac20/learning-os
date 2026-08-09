# Step 3 — Write devcontainer.json — the contract

Now the spec itself. It picks the base (`build` → your Dockerfile), adds one **pinned** Feature, sets a
**non-root** `remoteUser`, forwards a port, and runs a `postCreateCommand` after the workspace mounts.
Write it as **strict JSON** so every client accepts it:

```bash
cat > ~/hello-bench/.devcontainer/devcontainer.json <<'EOF'
{
  "name": "hello-bench",
  "build": { "dockerfile": "Dockerfile" },
  "features": {
    "ghcr.io/devcontainers/features/common-utils:2": {}
  },
  "remoteUser": "dev",
  "forwardPorts": [8000],
  "postCreateCommand": "pip install --user -r requirements-dev.txt"
}
EOF
```{{exec}}

Prove it parses — `json.tool` is strict (no comments, no trailing commas):

```bash
python3 -m json.tool ~/hello-bench/.devcontainer/devcontainer.json
```{{exec}}

The fields, decoded:

- **`build`** — one of three bases (`image` / `build` / `dockerComposeFile`); you chose the Dockerfile.
- **`features`** — a reusable OCI artifact merged into the build, **pinned** to `:2`. It's a dependency
  *and* a build cost — read its `install.sh` once, pin the version.
- **`remoteUser`** — non-root, matching the Dockerfile's `dev`.
- **`postCreateCommand`** — a **lifecycle hook** that runs after the workspace is mounted (per-clone
  setup). It must be **idempotent** — it re-runs on every recreate.

> The spec permits jsonc (comments, trailing commas); strict tools don't. Keeping it strict-clean means
> Codespaces, DevPod, and the CLI all read it. This jsonc-vs-JSON trap is the classic Monday break.

Click **Check** to verify the spec is valid JSON with the required keys and a non-root user.

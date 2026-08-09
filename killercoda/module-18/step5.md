# Step 5 — Hooks, recreate, and the secrets boundary

Two disciplines close the module: where hooks belong, and where secrets **don't**.

## The bake / personalize split

The four hook stations, and the line between them:

- **onCreate** — once at creation, generic and **bakeable** (a prebuild can cache it): `apt-get install …`
- **postCreate** — after the workspace mounts, bound to **this checkout**: `pip install -e ".[dev]"`
- **postStart** — every container start: daemons, refreshes
- **postAttach** — every attach: light session niceties

Put bakeable work in `postCreate` and a prebuild can't cache it — the warm start-time betrays the leak.
And every hook must be **idempotent**: it re-runs on every recreate, so the **run-twice test** (create,
recreate, verify) is mandatory — a `postCreate` that breaks on the second run breaks every recreate.

## The secrets boundary

`devcontainer.json` is **committed** — a secret in it ships to every clone and lives in git history
forever. Prove the negative, then implement the right channel:

```bash
cd ~/hello-bench && grep -q 'TOKEN' .devcontainer/devcontainer.json && echo "SECRET in spec — WRONG" || echo "no secret in the committed spec (good)"
```{{exec}}

The right channel — a **gitignored** env-file mount for project secrets:

```bash
echo '.devcontainer/devcontainer.env' >> .gitignore
```{{exec}}

```bash
printf 'API_TOKEN=dev-only-never-committed\n' > .devcontainer/devcontainer.env
```{{exec}}

```bash
git add -A && git status --short
```{{exec}}

`devcontainer.json` and `.gitignore` are tracked; `devcontainer.env` is **ignored** — the secret never
reaches the repo. For auth (e.g. `git push` from inside), use **ssh-agent forwarding**: the socket is
forwarded, signatures happen host-side, the private key never enters the container.

> Standing reflex: bench weird for more than 10 minutes? **Recreate first**, then fix the *spec* — never
> perform surgery on a disposable container. The blueprint is what you keep; the bench is cattle.

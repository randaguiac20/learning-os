# Step 4 — Materialize it — build and run the setup

This VM has Docker, so you can *be* the devcontainer client. Install and start Docker:

```bash
sudo apt-get update -qq && sudo apt-get install -y docker.io >/dev/null && sudo service docker start
```{{exec}}

Build the image the spec's `build` points at — this is the same `docker build` a client would run:

```bash
cd ~/hello-bench && sudo docker build -t hello-bench-dev -f .devcontainer/Dockerfile .devcontainer
```{{exec}}

Now run the container the way the spec would — **workspace mounted**, as the **remoteUser** `dev`:

```bash
sudo docker run --rm -v "$PWD":/workspace -w /workspace -u dev hello-bench-dev python app.py
```{{exec}}

That `docker run` is the middle of the `up` sequence made concrete: *create the container, mount the
workspace, become the remote user.* You should see `hello from the bench` — the environment materialized
from the file.

The `postCreateCommand` (`pip install --user -r requirements-dev.txt`) is what a real client runs **for**
you right after the mount. Run it yourself to watch the environment finish assembling:

```bash
sudo docker run --rm -v "$PWD":/workspace -w /workspace -u dev hello-bench-dev \
  bash -lc 'pip install --user -r requirements-dev.txt && echo "postCreate done: ruff + pytest installed"'
```{{exec}}

Everything on the wire mapped to an earlier module: the build is M16, the mount + uid is M17, the hooks
are M15. There is no magic — just your last modules composed.

Click **Check** to verify the dev image the spec references was built.

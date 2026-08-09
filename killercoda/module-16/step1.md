# Step 1 — Install Docker and run your first container

This is a full VM, so we install the Docker engine and the Compose plugin, then start the daemon. (On
your own Linux/macOS/WSL machine Docker is usually already installed — skip straight to `docker run`.)

```bash
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install -y docker.io docker-compose-v2 curl >/dev/null 2>&1
sudo service docker start
```{{exec}}

Confirm the client **and** engine are present:

```bash
docker version
```{{exec}}

Now run the smallest possible container and **read its output** — it narrates the pull → run pipeline:

```bash
docker run hello-world
```{{exec}}

Run a container from another distro and look at *its* userland — a whole other OS filesystem, on this
**one** kernel:

```bash
docker run -it ubuntu bash -c 'cat /etc/os-release | head -2; whoami'
```{{exec}}

`docker run` didn't boot a machine — it started a **process** with its own view of the filesystem. That
is the entire trick, and Step 2 proves it.

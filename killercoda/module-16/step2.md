# Step 2 — A container is just a process

The demystification. Start a long-running container **detached** (`-d`) and give it a name:

```bash
docker run -d --name sleeper ubuntu sleep 3000
```{{exec}}

Docker agrees it's running:

```bash
docker ps
```{{exec}}

Now find **the very same process** in the HOST's process table — no Docker involved, just plain `ps`:

```bash
ps -ef | grep -m1 "sleep 3000"
```{{exec}}

Look **inside** the container at the same process — here it is **PID 1**:

```bash
docker exec -it sleeper ps -ef
```{{exec}}

Same process, two views: an ordinary PID on the host, PID 1 inside its own PID namespace. You can even
kill it by its **host** PID and watch `docker ps` agree it's gone — but for now, stop it the Docker way:

```bash
docker stop sleeper && docker rm sleeper
```{{exec}}

**A container is a normal process in namespaces under cgroups, on the shared kernel.** No boot, no
guest OS — that's why it started instantly.

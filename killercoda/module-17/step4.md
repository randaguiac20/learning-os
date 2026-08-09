# Step 4 — Run a container with ctr, not Docker

Start a **detached** container. Behind this one command, `ctr` unpacks the image into a snapshot, writes a
`config.json`, and hands it to a **shim**, which calls **runc**:

```bash
sudo ctr run -d docker.io/library/alpine:latest demo sleep 600
```{{exec}}

The container exists — and its task (the live process) is running:

```bash
sudo ctr container ls
```{{exec}}

```bash
sudo ctr task ls
```{{exec}}

You should see `demo` with `STATUS RUNNING`. Now the payoff — look for `runc` in the process list, and
find it already **gone**:

```bash
ps -ef | grep -E 'runc|shim' | grep -v grep
```{{exec}}

You'll see a **shim** process (`containerd-shim-runc-v2`) — the container's supervisor, one per container
— but **no runc**. runc set the container up (created the namespaces and cgroups, `execve`d `sleep`) and
then **exited** in milliseconds. The shim is the parent now, holding stdio and waiting to reap the exit.
This is *the* lesson of the module, proven on your own machine: looking for a runc daemon and finding
nothing is the point.

Click **Check** to verify the container and its task are running. (Leave `demo` running — Step 5 cleans it up.)

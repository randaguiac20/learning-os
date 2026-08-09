# Step 4 — Run it: publish a port, add a volume

Run your image as a **named, detached** container and **publish** its port. `-p 8080:80` writes a DNAT
rule steering host `:8080` to the container's `:80`:

```bash
docker run -d --name web -p 8080:80 hello-web
```{{exec}}

```bash
docker ps
```{{exec}}

Fetch your page through the published port — served from the image **you** built:

```bash
curl -s localhost:8080
```{{exec}}

Now the **state boundary**. A container's writable layer dies with it, so persistent data goes in a
**named volume**. Write to one from a throwaway container:

```bash
docker run --rm -v mydata:/data alpine sh -c 'echo "survives the container" > /data/note.txt'
```{{exec}}

Read it back from a **different** container — the data outlived the first one:

```bash
docker run --rm -v mydata:/data alpine cat /data/note.txt
```{{exec}}

```bash
docker volume ls
```{{exec}}

State lives in the **volume** (outside), the container stays **disposable**. That is the cattle-not-pets
boundary the whole module turns on.

Click **Check** to verify `web` is running, answering on `:8080`, and the `mydata` volume exists.

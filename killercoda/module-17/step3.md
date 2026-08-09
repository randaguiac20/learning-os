# Step 3 — Pull an OCI image into the store

Pull a small image straight into containerd's content store — **no Docker involved**. This is the OCI
**distribution-spec** in action: the manifest is fetched first, then the layer blobs by digest.

```bash
sudo ctr image pull docker.io/library/alpine:latest
```{{exec}}

List what containerd now holds. Read the columns: `REF`, `TYPE`, `DIGEST` (the manifest's content
address), `SIZE`, `PLATFORMS`:

```bash
sudo ctr image ls
```{{exec}}

Look one level lower — the raw blobs now sitting in the content store, every one addressed by digest:

```bash
sudo ctr content ls | head
```{{exec}}

The `DIGEST` you see in `ctr image ls` is the content address of the image's **manifest**. Pull that same
digest on any machine, from any registry mirror, and you get byte-identical bytes — integrity is
**structural**, not a promise. This is the foundation the `pin-by-digest` habit from M16 was standing on
all along.

Click **Check** to verify the image landed in containerd's store.

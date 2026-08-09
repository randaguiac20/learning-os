# Step 5 — Read the manifest as raw JSON

An OCI image is just **JSON pointing at tarballs**. Pull the manifest straight out of the content store
and read it. Grab the manifest digest from `ctr image ls`, then fetch that blob and pretty-print it:

```bash
DIGEST=$(sudo ctr image ls | awk '/alpine/{print $3; exit}')
```{{exec}}

```bash
echo "manifest digest: $DIGEST"
```{{exec}}

```bash
sudo ctr content get "$DIGEST" | jq '.'
```{{exec}}

For a multi-arch image like `alpine`, this first blob is an **index** — a list of per-architecture
manifests. Follow one of the `manifests[].digest` values one level deeper to reach a real manifest, which
names its **config** blob and its ordered **layers**, each by digest:

```bash
MANIFEST=$(sudo ctr content get "$DIGEST" | jq -r '.manifests[0].digest // empty')
```{{exec}}

```bash
[ -n "$MANIFEST" ] && sudo ctr content get "$MANIFEST" | jq '{config: .config.digest, layers: [.layers[].digest]}' || echo "single-arch image — the first blob above WAS the manifest"
```{{exec}}

There it is: `config` (env, entrypoint, layer order) plus `layers` (the tar.gz filesystem diffs). That is
the entire **image-spec**, held in your hand — a manifest, a config, and layer tars, all linked by digest.

Now clean up the container you left running in Step 4:

```bash
sudo ctr task kill demo 2>/dev/null; sleep 1; sudo ctr container rm demo 2>/dev/null; echo cleaned
```{{exec}}

**Optional — the docker-UX experience, daemonlessly:** `nerdctl` gives you `nerdctl run` / `nerdctl ps` /
`nerdctl images` on top of this same containerd. It ships as a single static binary from the
[nerdctl releases](https://github.com/containerd/nerdctl/releases) (download, checksum-verify, extract) —
a nicety, not a requirement. Everything you did above already ran with **no Docker and no nerdctl** — just
containerd, `ctr`, and runc.

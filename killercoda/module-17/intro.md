# containerd & OCI — drive the runtime by hand

You have a real Linux VM in the terminal on the right — the kind of machine a Kubernetes node runs on.
In the next few minutes you'll install and start **containerd** (the runtime daemon that both Docker AND
Kubernetes drive), meet the three pieces of the stack (the daemon, the `ctr` client, and the `runc`
runtime), pull a real **OCI image** straight into containerd's store, run a container with `ctr` — with
**no Docker anywhere** — see a shim but no runc in the process list, and read an image manifest as raw JSON.

This is the layer *underneath* `docker run`: the machinery M16 hid from you, now in your hands.
Everything runs on the machine in front of you; nothing outside it is touched.

> Tip: **type every command yourself** — reading `ctr`, `ps`, and `jq` output is the skill; pasting past
> it skips the part that builds the memory.

Click **START** to begin.

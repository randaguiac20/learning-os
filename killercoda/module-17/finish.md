# Done — the layer under Docker, in your hands

In about 30 minutes you:

- Installed and started **containerd** — the runtime daemon both Docker and Kubernetes drive — and met the
  three pieces of the stack: the **daemon**, the **`ctr`** client, and the **`runc`** runtime.
- Listed containerd's own **namespaces** (its daemon multi-tenancy — the `moby`/`default` split that
  explains why "`ctr` shows nothing") and kept them separate from the kernel namespaces.
- Pulled a real **OCI image** straight into the content store with `ctr` — the **distribution-spec**, no
  Docker — and saw the blobs addressed by digest.
- Ran a **container with `ctr`**, watched its task go RUNNING, then found a **shim but no runc** in `ps` —
  runc set it up and exited; the shim is the parent.
- Read an image **manifest as raw JSON** with `jq`: manifest → config + ordered layers, all linked by
  digest. The whole **image-spec**, held in your hand.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
When every box is honestly true, M18 (Dev Containers) — Stage 5's final week — becomes current.

> The one-sentence takeaway: **M17 removes the last magic — the container stack climbed by hand from CLI
> to syscall — so Kubernetes (M19) arrives as familiar machinery seen from a new control plane, not a new
> mystery.**

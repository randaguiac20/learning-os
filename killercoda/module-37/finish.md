# Done — you ran the Infrastructure-as-Code lifecycle

In about 30 minutes you:

- **Installed OpenTofu** — the open-source Infrastructure-as-Code tool.
- **Wrote a config** (`main.tf`) declaring a *desired state* with the zero-cost `random` and `local` providers.
- Ran **`tofu init`** to download the providers, **`tofu plan`** to read the diff before changing anything,
  and **`tofu apply`** to create a **real** file — then inspected **`terraform.tfstate`**, the source of truth.
- **Changed the config**, re-planned to see the update, simulated **drift**, and **`tofu destroy`**ed the
  whole stack with one command — the cost law rehearsed.

This is the exact loop that provisions a real VM, managed database, or GPU on **AWS, Azure, or GCP** —
only the provider block changes. When you take the M36 API to a real free-tier account, remember the two
**cost laws**: **set a budget alert on day one**, and **STOP/DELETE (`tofu destroy`) every resource when
done** — especially a GPU.

**Back on the lesson page:** do the *Self-Check* (the cloud model, shared responsibility, build-vs-buy)
and tick the *Mastery checklist*. When every box is honestly true, Module 38 (Natural Language
Processing) — trained on cloud GPUs and served on the cloud you now command — becomes current.

> The one-sentence takeaway: **plan → apply → state → drift → destroy is the cloud's real skill — it
> transfers 1:1 from a local file to a global fleet.**

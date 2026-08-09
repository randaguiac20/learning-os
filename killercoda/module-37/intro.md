# Infrastructure as Code with OpenTofu — hands-on

You cannot use a real cloud account in a browser terminal — and you shouldn't want to, because this
module's law is **cost safety** (set a budget, and stop/delete every resource when done). So you'll learn
the **transferable** skill that the cloud is really built on: **Infrastructure as Code (IaC)** — defining
resources declaratively so anyone can recreate them with one command.

You'll use **OpenTofu** (the open-source successor to Terraform) with its **`random`** and **`local`**
providers — they create a *real* local file with **zero cloud and zero cost**. The lifecycle you drill
here — **init → plan → apply → state → drift → destroy** — is **identical** to provisioning a real VM,
managed database, or GPU instance. Only the provider block changes; the discipline transfers **1:1** to
AWS, Azure, and GCP.

All work lives in a throwaway `~/iac-lab/` directory. Nothing outside it is touched, and nothing costs a
cent.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> reading each `plan` before you `apply` is the "look before you leap" of infrastructure.

Click **START** to begin.

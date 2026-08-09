# Step 1 — Install OpenTofu

**OpenTofu** is the open-source Infrastructure-as-Code tool — same commands and config language as
Terraform, but a truly open licence. Install it with the official script:

```bash
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install.sh
chmod +x install.sh
./install.sh --install-method standalone
```{{exec}}

Confirm it's on your `PATH`:

```bash
tofu version
```{{exec}}

You should see a version line like `OpenTofu v1.x.x`.

> If the standalone installer can't reach GitHub in this sandbox, fall back to the Debian package method
> — same result:
> ```bash
> ./install.sh --install-method deb
> ```{{exec}}

That's the whole install. Everything from here is the IaC lifecycle — the part that transfers to any
cloud.

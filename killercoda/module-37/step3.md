# Step 3 — `tofu init` — download the providers

Before OpenTofu can do anything, it needs the provider plugins. `init` reads `main.tf` and downloads
them:

```bash
cd ~/iac-lab
tofu init
```{{exec}}

You should see **"OpenTofu has been successfully initialized!"**. Look at what it created:

```bash
ls -la ~/iac-lab
```{{exec}}

- `.terraform/` — the downloaded `random` and `local` provider plugins.
- `.terraform.lock.hcl` — a **lock file** pinning the exact provider versions, so the config is
  reproducible for anyone who clones it (the same idea as Module 17's dependency lockfiles).

`init` is safe and idempotent — it creates nothing in the real world, it just prepares the tools. The
`random` and `local` providers download reliably with no account and no cost.

Click **Check** to verify the providers initialized.

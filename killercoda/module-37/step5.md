# Step 5 — `tofu apply` — create it, then inspect the state

`apply` executes the plan and creates the **real** resources. `-auto-approve` skips the interactive
"yes" prompt (in production you review the plan and type `yes`):

```bash
cd ~/iac-lab
tofu apply -auto-approve
```{{exec}}

The `local_file` now exists on disk — a real resource OpenTofu created:

```bash
cat ~/iac-lab/server-name.txt
```{{exec}}

You should see `Provisioned server: <two-word-name>`. Now inspect the **state file** — OpenTofu's record
of everything it created and manages:

```bash
ls -l ~/iac-lab/terraform.tfstate
```{{exec}}

```bash
tofu show
```{{exec}}

**`terraform.tfstate` is the source of truth** that links your config to the real resources. Here it
records the pet name and the file. In real cloud it holds resource IDs, IP addresses, and sometimes
secrets — which is why it's sensitive and, on a team, stored in a shared **remote backend** instead of on
your laptop.

Click **Check** to verify the file was created with the right content and the state file exists.

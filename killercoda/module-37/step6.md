# Step 6 — Change, re-plan, then destroy

Real infrastructure changes over time. Edit the desired state — ask for a **3-word** name — and re-plan
to see how OpenTofu handles an update:

```bash
cd ~/iac-lab
sed -i 's/length = 2/length = 3/' main.tf
tofu plan
```{{exec}}

The plan now shows a **replace** (`1 to add, 0 to change, 1 to destroy`): the pet name can't be resized
in place, so OpenTofu will destroy the old one and create a new one, then rewrite the file. Apply it:

```bash
tofu apply -auto-approve
cat ~/iac-lab/server-name.txt
```{{exec}}

A new three-word name. That is **drift management**: you changed the config, OpenTofu computed the exact
update. (Try the reverse too — delete `server-name.txt` by hand, then `tofu plan`: it detects the drift
and plans to recreate the file.)

Now the **cost law**, rehearsed — tear the whole stack down with one command:

```bash
tofu destroy -auto-approve
```{{exec}}

```bash
ls ~/iac-lab/server-name.txt 2>/dev/null || echo "file gone — destroy complete"
```{{exec}}

On real cloud, `tofu destroy` is exactly how you obey **"STOP/DELETE when done"** — the single-command
teardown that prevents the idle-GPU bill. Provision → use → **destroy**.

You've run the entire Infrastructure-as-Code lifecycle. Only the provider block separates this from
spinning up a real VM, database, or GPU.

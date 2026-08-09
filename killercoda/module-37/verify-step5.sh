#!/bin/bash
# Killercoda step verifier: pass when apply created the real local_file and recorded it in state.
lab="$HOME/iac-lab"
[ -d "$lab" ] || { echo "Working dir ~/iac-lab not found — start from Step 2."; exit 1; }
[ -f "$lab/server-name.txt" ] || { echo "server-name.txt not found — run: cd ~/iac-lab && tofu apply -auto-approve"; exit 1; }
if ! grep -q "Provisioned server:" "$lab/server-name.txt"; then
  echo "server-name.txt exists but its content is wrong — it should start 'Provisioned server:'. Re-check main.tf and re-apply."
  exit 1
fi
[ -f "$lab/terraform.tfstate" ] || { echo "No terraform.tfstate — apply didn't record state. Run: tofu apply -auto-approve"; exit 1; }
if ! grep -q "local_file" "$lab/terraform.tfstate"; then
  echo "The state file doesn't record the local_file resource — run: tofu apply -auto-approve"
  exit 1
fi
echo "Verified: tofu apply created server-name.txt with the right content, and terraform.tfstate records the resource. That's the IaC lifecycle."
exit 0

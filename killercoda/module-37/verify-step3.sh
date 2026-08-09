#!/bin/bash
# Killercoda step verifier: pass (exit 0) when OpenTofu initialized the random+local providers.
lab="$HOME/iac-lab"
[ -d "$lab" ] || { echo "Working dir ~/iac-lab not found — create it and write main.tf (Step 2)."; exit 1; }
[ -f "$lab/main.tf" ] || { echo "main.tf not found — write it as shown in Step 2."; exit 1; }
[ -f "$lab/.terraform.lock.hcl" ] || { echo "No .terraform.lock.hcl — run: cd ~/iac-lab && tofu init"; exit 1; }
[ -d "$lab/.terraform" ] || { echo "No .terraform/ providers dir — run: cd ~/iac-lab && tofu init"; exit 1; }
if ! grep -q "hashicorp/random" "$lab/.terraform.lock.hcl" || ! grep -q "hashicorp/local" "$lab/.terraform.lock.hcl"; then
  echo "The random and local providers aren't both locked — check main.tf, then re-run: tofu init"
  exit 1
fi
echo "Verified: OpenTofu initialized — the random and local providers are downloaded and locked."
exit 0

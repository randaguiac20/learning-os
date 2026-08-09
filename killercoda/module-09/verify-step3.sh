#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the Ed25519 keypair exists, is authorized, and logs in.
key="$HOME/.ssh/id_ed25519"
[ -f "$key" ] || { echo "Private key $key not found — generate it in Step 2 (ssh-keygen -t ed25519)."; exit 1; }
[ -f "$key.pub" ] || { echo "Public key $key.pub not found — generate the pair in Step 2."; exit 1; }
auth="$HOME/.ssh/authorized_keys"
[ -f "$auth" ] || { echo "$auth not found — append your public key to it (Step 3)."; exit 1; }
pub=$(awk '{print $2}' "$key.pub")
grep -qF "$pub" "$auth" || { echo "Your public key is not in authorized_keys — run: cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys (Step 3)."; exit 1; }
if ! ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -o ConnectTimeout=5 localhost true 2>/dev/null; then
  echo "Key-based login to localhost failed — is sshd running (service ssh start) and the key authorized? (Step 3)"
  exit 1
fi
echo "Verified: Ed25519 keypair exists, is authorized, and logs in to localhost password-free. Auth #2 works."
exit 0

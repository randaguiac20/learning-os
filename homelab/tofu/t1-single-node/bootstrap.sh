#!/usr/bin/env bash
# T1 bootstrap — create a free single-node Kubernetes cluster on your laptop with k3d
# (k3s in Docker). Requires Docker running. ~30 seconds, $0.
#
#   k3d:  https://k3d.io           kubectl: https://kubernetes.io/docs/tasks/tools/
#   tofu: https://opentofu.org     (or Terraform)
#
# After this, run:  tofu init && tofu apply   (in this directory)
set -euo pipefail

CLUSTER="${CLUSTER:-homelab}"

# --- Preflight: every tool must exist, or we stop HERE and no cluster is created. ---
missing=0
need() { # need <cmd> <install hint>
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "  MISSING: $1  ->  install with:  $2"
    missing=1
  fi
}
need docker  "https://docs.docker.com/engine/install/"
need k3d     "brew install k3d   (or: curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash)"
need kubectl "brew install kubectl   (or: https://kubernetes.io/docs/tasks/tools/)"
need tofu    "brew install opentofu   (NOT 'apt install tofu' — that is an unrelated imaging package, see README)"

if [ "${missing}" -ne 0 ]; then
  echo
  echo "=========================================================================="
  echo " ABORTED — the tools above are missing. NOTHING was created."
  echo " Install them (see README.md, 'Install the tools'), then re-run:"
  echo "   ./bootstrap.sh"
  echo " Do NOT proceed to 'tofu apply' until this script ends with 'Ready.'"
  echo "=========================================================================="
  exit 1
fi

# Docker must not only be installed but actually be running and reachable.
if ! docker info >/dev/null 2>&1; then
  echo "ABORTED — Docker is installed but not reachable (daemon stopped, or no permission)."
  echo "Start it (e.g. 'sudo systemctl start docker') and make sure your user is in the"
  echo "docker group ('sudo usermod -aG docker \$USER', then log out/in). Then re-run."
  exit 1
fi

if k3d cluster list | grep -q "^${CLUSTER}\b"; then
  echo "Cluster '${CLUSTER}' already exists."
else
  echo "Creating single-node k3d cluster '${CLUSTER}' (maps localhost:8080 -> ingress)..."
  k3d cluster create "${CLUSTER}" --agents 0 -p "8080:80@loadbalancer"
fi

kubectl config use-context "k3d-${CLUSTER}"
kubectl cluster-info
echo "Ready. Context: k3d-${CLUSTER}. Now: tofu init && tofu apply"

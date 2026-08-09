#!/bin/bash
# Killercoda step verifier: pass (exit 0) when an OCI image is pulled into containerd's content store.
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
if ! command -v ctr >/dev/null 2>&1; then
  echo "ctr not found — run the install command in Step 1 first."
  exit 1
fi
if ! $SUDO ctr version >/dev/null 2>&1; then
  echo "containerd is not reachable — start it (Step 1): sudo systemctl enable --now containerd  (or run containerd directly)."
  exit 1
fi
if ! $SUDO ctr image ls -q 2>/dev/null | grep -q 'alpine'; then
  echo "No alpine image in the store — pull it with: sudo ctr image pull docker.io/library/alpine:latest"
  exit 1
fi
echo "Verified: containerd is up and an alpine OCI image is in its content store. Distribution-spec, in action."
exit 0

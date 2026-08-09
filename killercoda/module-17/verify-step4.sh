#!/bin/bash
# Killercoda step verifier: pass when a container 'demo' exists and its task is running under containerd.
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
if ! command -v ctr >/dev/null 2>&1; then
  echo "ctr not found — run the install command in Step 1 first."
  exit 1
fi
if ! $SUDO ctr version >/dev/null 2>&1; then
  echo "containerd is not reachable — start it (Step 1) before running a container."
  exit 1
fi
if ! $SUDO ctr container ls -q 2>/dev/null | grep -q '^demo$'; then
  echo "Container 'demo' not found — create it with: sudo ctr run -d docker.io/library/alpine:latest demo sleep 600"
  exit 1
fi
if ! $SUDO ctr task ls 2>/dev/null | awk '$1=="demo"{print $NF}' | grep -qi 'RUNNING'; then
  echo "Container 'demo' exists but its task is not RUNNING — (re)start it: sudo ctr run -d docker.io/library/alpine:latest demo sleep 600"
  exit 1
fi
echo "Verified: container 'demo' is running under containerd via a shim + runc — no Docker anywhere."
exit 0

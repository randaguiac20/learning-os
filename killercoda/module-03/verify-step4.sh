#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the 'tree' package is installed via apt/dpkg.
if ! command -v tree >/dev/null 2>&1; then
  echo "'tree' is not on PATH — install it with: sudo apt update && sudo apt install -y tree"
  exit 1
fi

if ! dpkg -s tree >/dev/null 2>&1; then
  echo "'tree' is not recorded in the dpkg database — install it the packaged way: sudo apt install -y tree"
  exit 1
fi

if ! dpkg -L tree | grep -q '/usr/bin/tree'; then
  echo "dpkg shows no /usr/bin/tree — reinstall with: sudo apt install --reinstall -y tree"
  exit 1
fi

echo "Verified: 'tree' is installed via apt and inventoried by dpkg (FHS-shaped under /usr/bin). Software lifecycle owned."
exit 0

#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the dev image the spec references has been built.
if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found — install and start it in Step 4: sudo apt-get install -y docker.io && sudo service docker start"
  exit 1
fi

if ! sudo docker image inspect hello-bench-dev >/dev/null 2>&1; then
  echo "Image 'hello-bench-dev' not found — build it in Step 4:"
  echo "  cd ~/hello-bench && sudo docker build -t hello-bench-dev -f .devcontainer/Dockerfile .devcontainer"
  exit 1
fi

echo "Verified: hello-bench-dev is built — the image the devcontainer references materializes. The bench is real."
exit 0

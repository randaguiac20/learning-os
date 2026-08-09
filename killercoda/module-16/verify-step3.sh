#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the learner's 'hello-web' image was built.
if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found — run the install command in Step 1."
  exit 1
fi
if ! docker image inspect hello-web >/dev/null 2>&1; then
  echo "Image 'hello-web' not found — build it in ~/docker-lab with: docker build -t hello-web ."
  exit 1
fi
echo "Verified: image 'hello-web' exists. docker build worked — you turned a Dockerfile into an image."
exit 0

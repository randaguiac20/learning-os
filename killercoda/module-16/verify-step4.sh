#!/bin/bash
# Killercoda step verifier: pass when 'web' runs, answers on :8080, and the 'mydata' volume exists.
if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found — run the install command in Step 1."
  exit 1
fi
if ! docker ps --format '{{.Names}}' | grep -qx web; then
  echo "Container 'web' is not running — start it with: docker run -d --name web -p 8080:80 hello-web"
  exit 1
fi
if ! curl -fsS http://localhost:8080 >/dev/null 2>&1; then
  echo "Nothing answered on http://localhost:8080 — check the '-p 8080:80' publish and that 'web' is up."
  exit 1
fi
if ! docker volume inspect mydata >/dev/null 2>&1; then
  echo "Named volume 'mydata' not found — create it as shown: docker run --rm -v mydata:/data alpine ..."
  exit 1
fi
echo "Verified: 'web' is running, answering on :8080, and the 'mydata' volume persisted. State boundary proven."
exit 0

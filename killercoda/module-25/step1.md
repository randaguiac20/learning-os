# Step 1 — Get a real Prometheus

Build the sandbox, then fetch the static Prometheus binary — it's a single self-contained executable, no
dependencies. If the download is flaky, the package manager is the fallback.

```bash
mkdir -p ~/obs-lab && cd ~/obs-lab
```{{exec}}

```bash
VER=2.53.0
curl -fsSL -o prom.tar.gz \
  "https://github.com/prometheus/prometheus/releases/download/v${VER}/prometheus-${VER}.linux-amd64.tar.gz" \
  && tar --strip-components=1 -xzf prom.tar.gz \
  || { sudo apt-get update -qq && sudo apt-get install -y prometheus; }
```{{exec}}

Confirm you have a working binary (the local one if you downloaded it, otherwise the packaged one):

```bash
( ./prometheus --version 2>/dev/null || prometheus --version )
```{{exec}}

You now have `prometheus`. That's the whole "monitoring stack" — one static binary. The *stack* is an
afternoon; the **discipline** (which questions, which alerts, which severities) is the module.

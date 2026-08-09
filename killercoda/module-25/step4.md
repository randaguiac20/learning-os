# Step 4 — Start Prometheus and query the API

Start Prometheus against your config in the background, give it a few seconds to scrape, then ask it the
most fundamental question — **which targets are up?** — over the HTTP query API.

```bash
cd ~/obs-lab
PROM=./prometheus; command -v $PROM >/dev/null 2>&1 || PROM=prometheus
nohup $PROM --config.file=prometheus.yml >/dev/null 2>&1 &
```{{exec}}

Give it time to complete a scrape cycle, then query `up`:

```bash
sleep 8
curl -s 'localhost:9090/api/v1/query?query=up' | head -c 600; echo
```{{exec}}

In the JSON, each target reports a value of `1` (reachable) or `0` (down). **`up` is the cheapest, most
important series you own** — it comes free with every scrape, and it's what you'll alert on when a target
vanishes.

If a target reads `0` or is missing, re-check that your app from Step 2 is still running
(`curl -s localhost:8000/metrics`) and that Prometheus started.

Click **Check** to verify Prometheus is running and at least one target is `up == 1`.

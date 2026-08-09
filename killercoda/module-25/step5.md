# Step 5 — A golden-signal query and the absent-metric trap

Generate some traffic, then ask a real **golden-signal** question — *traffic*, as a per-second rate off
the counter:

```bash
for i in $(seq 1 20); do curl -s localhost:8000/metrics >/dev/null; done
curl -s 'localhost:9090/api/v1/query?query=rate(app_requests_total[1m])' | head -c 400; echo
```{{exec}}

`rate()` turns the ever-climbing counter into "requests per second, right now" — and it would survive an
app restart, because it absorbs the counter reset. (Querying the raw `app_requests_total` instead would
tell you about *uptime*, not current behaviour — the reason counters are always queried through `rate()`.)

### The absent-metric trap

Now stop the app and watch the target go down from Prometheus's point of view:

```bash
pkill -f obs-lab/app.py
sleep 8
curl -s 'localhost:9090/api/v1/query?query=up{job="metrics-app"}' | head -c 400; echo
```{{exec}}

`up` for the app flips to `0` — Prometheus tried to scrape and failed. **This is the standing alert:
`up == 0`.** Here's the trap: a threshold like `app_up < 1` can't fire when the target disappears,
because `app_up` returns *no data at all* — and you can't cross a threshold on data that isn't there.
**Absence needs its own alert.**

Reason about severity with the dividing question — *must a human act NOW?* A single-instance, user-facing
app being down → **page**. A redundant replica down while others serve → **ticket**. That judgment, not
the YAML, is the module.

You stood up a real Prometheus, scraped a target you wrote, queried `up` and a golden signal over the
API, and saw why absence needs its own alert. That's Module 25, hands-on.

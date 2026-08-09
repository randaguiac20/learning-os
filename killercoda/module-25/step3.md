# Step 3 — Write the scrape config

Prometheus reads a `prometheus.yml`. Declare a global scrape interval and **two jobs**: Prometheus
scraping itself, and your app. The `job` label is a **dimension** you'll aggregate by later.

```bash
cat > ~/obs-lab/prometheus.yml <<'YML'
global:
  scrape_interval: 5s
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets: ["localhost:9090"]
  - job_name: metrics-app
    static_configs:
      - targets: ["localhost:8000"]
YML
```{{exec}}

Read it back:

```bash
cat ~/obs-lab/prometheus.yml
```{{exec}}

This file **is** the inventory: every service Prometheus knows about is listed here explicitly. Pull-based
monitoring means a target you forgot to scrape is a service you forgot you ran — the scrape list is
M24's attack-surface enumeration, automated.

Click **Check** to verify the config declares the `metrics-app` job pointing at `localhost:8000`.

# Step 2 — Run a target that exposes /metrics

Prometheus scrapes HTTP endpoints that speak its text format. Write a tiny app — Python standard library
only, so it always runs — that exposes a **counter** and a **gauge**:

```bash
cat > ~/obs-lab/app.py <<'PY'
import http.server
reqs = 0
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        global reqs
        reqs += 1
        body = (
            "# HELP app_requests_total Requests handled\n"
            "# TYPE app_requests_total counter\n"
            f"app_requests_total {reqs}\n"
            "# HELP app_up App self-health\n"
            "# TYPE app_up gauge\n"
            "app_up 1\n"
        ).encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; version=0.0.4")
        self.end_headers(); self.wfile.write(body)
    def log_message(self, *a): pass
http.server.HTTPServer(("127.0.0.1", 8000), H).serve_forever()
PY
```{{exec}}

Start it in the background and read what it says:

```bash
nohup python3 ~/obs-lab/app.py >/dev/null 2>&1 &
sleep 1
curl -s localhost:8000/metrics
```{{exec}}

**This is what an exporter actually says:** a `# HELP`/`# TYPE` header, then `name{labels} value` lines.
Each `curl` you make increments the counter — a counter only ever goes up (until a restart resets it to
zero).

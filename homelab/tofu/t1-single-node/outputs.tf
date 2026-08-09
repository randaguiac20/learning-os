output "app_namespace" {
  description = "Namespace the demo app runs in"
  value       = kubernetes_namespace.demo.metadata[0].name
}

output "app_url" {
  description = "Stable URL for the demo app (via Traefik ingress — survives destroy/apply)"
  value       = "http://${var.app_name}.localhost:8080"
}

output "grafana_url" {
  description = "Stable URL for Grafana (if installed) — user: admin, password: var.grafana_admin_password"
  value       = var.install_grafana ? "http://grafana.localhost:8080  (user: admin, password: the grafana_admin_password variable — default 'homelab-admin')" : "grafana disabled (install_grafana = false)"
}

output "port_forward_fallback" {
  description = "Fallback if ingress is unavailable. NOTE: these tunnels die whenever the pod behind them is recreated (any destroy/apply) — re-run them after every rebuild."
  value = join("\n", [
    "kubectl -n demo port-forward svc/${var.app_name} 8088:80          # http://localhost:8088",
    "kubectl -n observability port-forward svc/grafana 3000:80  # http://localhost:3000",
  ])
}

# T1 workload: a tiny demo web app + (optionally) Grafana — the smallest honest
# "app + a dashboard" slice, deployed the same GitOps-friendly way you'll scale to
# T2 (3-node) and T3 (cloud). Everything here is free and runs on a laptop.

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
    labels = {
      "app.kubernetes.io/part-of" = "learning-os-homelab"
      "homelab.tier"              = "t1"
    }
  }
}

# traefik/whoami: a ~4 MB image that echoes request info — no build, pulls fast.
resource "kubernetes_deployment" "web" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.demo.metadata[0].name
    labels    = { app = var.app_name }
  }
  spec {
    replicas = 1
    selector {
      match_labels = { app = var.app_name }
    }
    template {
      metadata {
        labels = { app = var.app_name }
      }
      spec {
        container {
          name  = var.app_name
          image = "traefik/whoami:v1.10"
          port {
            container_port = 80
          }
          resources {
            requests = { cpu = "10m", memory = "16Mi" }
            limits   = { cpu = "100m", memory = "64Mi" }
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 2
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.demo.metadata[0].name
  }
  spec {
    selector = { app = var.app_name }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}

# Ingress: k3s ships Traefik, and bootstrap.sh maps localhost:8080 -> the cluster's
# ingress load balancer. Declaring the route here (instead of hand-run port-forwards,
# which die whenever a pod is recreated) is what makes the URL survive destroy/apply.
resource "kubernetes_ingress_v1" "web" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.demo.metadata[0].name
  }
  spec {
    ingress_class_name = "traefik"
    rule {
      host = "${var.app_name}.localhost"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.web.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

# Observability starter: Grafana via Helm. The full Prometheus/Alertmanager/Loki
# stack is the T2 step (see ../../README.md) — kept out of T1 to stay laptop-light.
resource "helm_release" "grafana" {
  count            = var.install_grafana ? 1 : 0
  name             = "grafana"
  namespace        = "observability"
  create_namespace = true
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "8.5.1"

  # Keep it tiny and ephemeral for T1; T2 adds persistence + real datasources.
  set {
    name  = "persistence.enabled"
    value = "false"
  }

  # Fixed admin password: without this the chart generates a new random one on every
  # rebuild, so destroy/apply would silently invalidate the login you knew.
  set_sensitive {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }

  # Same stable-URL story as the app: route grafana.localhost through Traefik so
  # the dashboard is reachable at localhost:8080 with no port-forward.
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.ingressClassName"
    value = "traefik"
  }
  set {
    name  = "ingress.hosts[0]"
    value = "grafana.localhost"
  }
  set {
    name  = "resources.requests.cpu"
    value = "25m"
  }
  set {
    name  = "resources.requests.memory"
    value = "64Mi"
  }
}

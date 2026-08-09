variable "kubeconfig" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kube context to target (k3d prefixes cluster names with 'k3d-')"
  type        = string
  default     = "k3d-homelab"
}

variable "app_name" {
  description = "Demo app name"
  type        = string
  default     = "whoami"
}

variable "grafana_admin_password" {
  description = "Grafana admin password. Fixed so it survives destroy/apply (the chart would otherwise generate a new random one each rebuild). Local-lab default — override for anything shared."
  type        = string
  default     = "homelab-admin"
  sensitive   = true
}

variable "install_grafana" {
  description = "Install Grafana via Helm (the observability starter). Prometheus stack is the T2 step."
  type        = bool
  default     = true
}

# =============================================================================
# Inputs for the argocd module
# =============================================================================

variable "argocd_namespace" {
  description = "Kubernetes namespace for the ArgoCD control plane"
  type        = string
  default     = "argocd"
}

variable "argocd_chart_version" {
  description = "Version of the argo-cd Helm chart from argoproj/argo-helm"
  type        = string
}

variable "argocd_app_version" {
  description = "Version of the ArgoCD application embedded in the chart (for reference and output exposure)"
  type        = string
}

variable "values_file_path" {
  description = "Path to the Helm values file"
  type        = string
  default     = ""
}

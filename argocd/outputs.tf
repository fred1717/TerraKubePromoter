# =============================================================================
# Outputs for the argocd module
# =============================================================================

output "namespace" {
  description = "Kubernetes namespace where ArgoCD is installed"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "chart_version" {
  description = "Version of the argo-cd Helm chart installed"
  value       = helm_release.argocd.version
}

output "app_version" {
  description = "Version of the ArgoCD application embedded in the chart"
  value       = var.argocd_app_version
}

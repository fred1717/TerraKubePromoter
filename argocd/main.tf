# =============================================================================
# ArgoCD control plane
# Installed via the official argo-cd Helm chart (argoproj/argo-helm)
# into a dedicated namespace labelled with the restricted Pod Security Standard
# =============================================================================

# -----------------------------------------------------------------------------
# Namespace
# -----------------------------------------------------------------------------

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace

    labels = {
      "app.kubernetes.io/name"                            = var.argocd_namespace
      "app.kubernetes.io/part-of"                         = "argocd"
      "pod-security.kubernetes.io/enforce"                = "restricted"
      "pod-security.kubernetes.io/enforce-version"        = "v1.35"
      "pod-security.kubernetes.io/audit"                  = "restricted"
      "pod-security.kubernetes.io/audit-version"          = "v1.35"
      "pod-security.kubernetes.io/warn"                   = "restricted"
      "pod-security.kubernetes.io/warn-version"           = "v1.35"
    }
  }
}

# -----------------------------------------------------------------------------
# Helm release
# -----------------------------------------------------------------------------

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  timeout         = 600
  atomic          = true
  cleanup_on_fail = true
  wait            = true

  values = [
    file(var.values_file_path != "" ? var.values_file_path : "${path.module}/values.yaml")
  ]
}

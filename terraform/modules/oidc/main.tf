# =============================================================================
# OIDC providers - shared module for AWS IAM OIDC federation
# =============================================================================
# 2 providers are managed here:
# - eks_irsa: federation for EKS service accounts (IRSA pattern)
# - github_actions: federation for GitHub Actions workflows
# =============================================================================

data "tls_certificate" "eks_irsa" {
  url = "https://${var.eks_oidc_issuer_url}"
}

resource "aws_iam_openid_connect_provider" "eks_irsa" {
  url             = "https://${var.eks_oidc_issuer_url}"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_irsa.certificates[0].sha1_fingerprint]

  tags = {
    Name = "${var.name_prefix}-oidc"
  }
}

data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]

  tags = {
    Name = "github-actions-oidc"
  }
}

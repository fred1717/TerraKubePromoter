# =============================================================================
# Root-level outputs
# =============================================================================

# -----------------------------------------------------------------------------
# Backend
# -----------------------------------------------------------------------------

output "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.backend.s3_bucket_name
}

# -----------------------------------------------------------------------------
# EKS
# -----------------------------------------------------------------------------

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint URL for the EKS API server"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority" {
  description = "Base64-encoded certificate authority data for the cluster"
  value       = module.eks.cluster_certificate_authority
}

output "oidc_provider_arn" {
  description = "ARN of the OIDC provider for IRSA"
  value       = module.eks.oidc_provider_arn
}

# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

# -----------------------------------------------------------------------------
# ECR
# -----------------------------------------------------------------------------

output "ecr_repository_url" {
  description = "URL of the ECR repository for the Flask application image"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr.repository_arn
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}

# -----------------------------------------------------------------------------
# ECR scanning
# -----------------------------------------------------------------------------

output "ecr_scan_type" {
  description = "Active ECR scan type: BASIC or ENHANCED"
  value       = module.ecr_scanning.scan_type
}

output "ecr_scan_frequency" {
  description = "Active ECR scan frequency: SCAN_ON_PUSH or CONTINUOUS_SCAN"
  value       = module.ecr_scanning.scan_frequency
}

# -----------------------------------------------------------------------------
# EKS addons
# -----------------------------------------------------------------------------

output "vpc_cni_addon_arn" {
  description = "ARN of the VPC CNI managed addon"
  value       = module.eks_addons.vpc_cni_addon_arn
}

output "vpc_cni_addon_version" {
  description = "Active version of the VPC CNI managed addon"
  value       = module.eks_addons.vpc_cni_addon_version
}

output "network_policy_enabled" {
  description = "Whether NetworkPolicy enforcement is active on the VPC CNI"
  value       = module.eks_addons.network_policy_enabled
}

# -----------------------------------------------------------------------------
# ArgoCD
# -----------------------------------------------------------------------------

output "argocd_namespace" {
  description = "Kubernetes namespace where ArgoCD is installed"
  value       = module.argocd.namespace
}

output "argocd_chart_version" {
  description = "Active version of the argo-cd Helm chart"
  value       = module.argocd.chart_version
}

output "argocd_app_version" {
  description = "Active version of the ArgoCD application embedded in the chart"
  value       = module.argocd.app_version
}

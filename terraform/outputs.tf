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
  value       = module.oidc.eks_irsa_provider_arn
}

# -----------------------------------------------------------------------------
# AWS context
# -----------------------------------------------------------------------------

output "aws_region" {
  description = "AWS region the stack is deployed in"
  value       = var.aws_region
}

output "project_name" {
  description = "Project name, used as the lowercase project tag value"
  value       = var.project_name
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
  value       = module.subnets.private_subnet_ids
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.subnets.public_subnet_ids
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

# -----------------------------------------------------------------------------
# GitHub OIDC
# -----------------------------------------------------------------------------

output "gha_ecr_push_role_arn" {
  description = "ARN of the role assumed by app-ci.yml to push images to ECR"
  value       = module.cicd_iam_roles.ecr_push_role_arn
}

output "gha_terraform_role_arn" {
  description = "ARN of the role assumed by terraform-ci.yml to apply Terraform"
  value       = module.cicd_iam_roles.terraform_role_arn
}

output "gha_promote_role_arn" {
  description = "ARN of the role assumed by promote.yml to read ECR image digests"
  value       = module.cicd_iam_roles.promote_role_arn
}

# -----------------------------------------------------------------------------
# GitHub repository
# -----------------------------------------------------------------------------

output "github_org" {
  description = "GitHub organisation or user that owns the repository"
  value       = var.github_org
}

output "github_repo" {
  description = "GitHub repository name"
  value       = var.github_repo
}

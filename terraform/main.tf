# =============================================================================
# Root module — orchestrates all child modules
# =============================================================================
# IMPORTANT: 2-step initialisation process
# 1. Comment out the "backend" block below.
#    Run: terraform init && terraform apply
#    This creates the S3 bucket.
# 2. Uncomment the "backend" block below.
#    Run: terraform init
#    Terraform will prompt to migrate local state to S3.
# =============================================================================

terraform {
  backend "s3" {
    bucket       = "terrakubepromoter-dev-tfstate"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

# -----------------------------------------------------------------------------
# Backend — S3 bucket and DynamoDB table for remote state
# -----------------------------------------------------------------------------

module "backend" {
  source = "./modules/backend"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# IAM — roles and policies for EKS
# -----------------------------------------------------------------------------

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# VPC — network layer
# -----------------------------------------------------------------------------

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# Endpoints — VPC endpoints for private AWS service access
# -----------------------------------------------------------------------------

module "endpoints" {
  source = "./modules/endpoints"

  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr               = module.vpc.vpc_cidr
  private_subnet_ids     = module.vpc.private_subnet_ids
  aws_region             = var.aws_region
  private_route_table_id = module.vpc.private_route_table_id
}

# -----------------------------------------------------------------------------
# EKS — cluster and managed node group
# -----------------------------------------------------------------------------

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  cluster_version    = var.cluster_version
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = var.node_instance_type
  node_desired_count = var.node_desired_count
  node_min_count     = var.node_min_count
  node_max_count     = var.node_max_count
  cluster_admin_arn  = var.cluster_admin_arn

  depends_on = [module.endpoints]
}

# -----------------------------------------------------------------------------
# EKS addons — managed addons (VPC CNI with NetworkPolicy enforcement)
# -----------------------------------------------------------------------------

module "eks_addons" {
  source = "./modules/eks_addons"

  cluster_name          = module.eks.cluster_name
  vpc_cni_addon_version = var.vpc_cni_addon_version

  depends_on = [module.eks]
}

# -----------------------------------------------------------------------------
# ECR — container registry for the Flask application image
# -----------------------------------------------------------------------------

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# ECR scanning — registry-wide vulnerability scanning configuration
# -----------------------------------------------------------------------------

module "ecr_scanning" {
  source = "./modules/ecr_scanning"
}

# -----------------------------------------------------------------------------
# ArgoCD — GitOps control plane installed via Helm
# -----------------------------------------------------------------------------

module "argocd" {
  source = "./modules/argocd"

  argocd_chart_version = var.argocd_chart_version
  argocd_app_version   = var.argocd_app_version

  depends_on = [module.eks_addons]
}

# -----------------------------------------------------------------------------
# GitHub OIDC — federation provider and IAM roles for GitHub Actions
# -----------------------------------------------------------------------------

module "github_oidc" {
  source = "./modules/github_oidc"

  github_org                 = var.github_org
  github_repo                = var.github_repo
  ecr_repository_arn         = module.ecr.repository_arn
  terraform_state_bucket_arn = "arn:aws:s3:::${var.project_name}-${var.environment}-tfstate"
}

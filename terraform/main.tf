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
# Backend — S3 bucket for remote state
# -----------------------------------------------------------------------------

module "backend" {
  source = "./modules/backend"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# IAM roles — EKS cluster and node IAM roles with their trust policies
# -----------------------------------------------------------------------------

module "iam_roles" {
  source = "./modules/iam_roles"

  name_prefix = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# IAM policies — AWS-managed policy attachments to the EKS roles
# -----------------------------------------------------------------------------

module "iam_policies" {
  source = "./modules/iam_policies"

  eks_cluster_role_name = module.iam_roles.eks_cluster_role_name
  eks_node_role_name    = module.iam_roles.eks_node_role_name
}

# -----------------------------------------------------------------------------
# VPC — VPC and Internet Gateway only
# -----------------------------------------------------------------------------

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
}

# -----------------------------------------------------------------------------
# Subnets — public and private subnets across the availability zones
# -----------------------------------------------------------------------------

module "subnets" {
  source = "./modules/subnets"

  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  name_prefix          = "${var.project_name}-${var.environment}"
  cluster_name         = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# Route tables — public and private route tables, with associations
# -----------------------------------------------------------------------------

module "route_tables" {
  source = "./modules/route_tables"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  name_prefix         = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# NAT — NAT gateway, Elastic IP, and private default route
# -----------------------------------------------------------------------------

module "nat" {
  source = "./modules/nat"

  public_subnet_id       = module.subnets.public_subnet_ids[0]
  private_route_table_id = module.route_tables.private_route_table_id
  name_prefix            = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# Security groups — shared security groups across the VPC
# -----------------------------------------------------------------------------

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  name_prefix = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# Endpoints — VPC endpoints for private AWS service access
# -----------------------------------------------------------------------------

module "endpoints" {
  source = "./modules/endpoints"

  project_name                = var.project_name
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.subnets.private_subnet_ids
  private_route_table_id      = module.route_tables.private_route_table_id
  endpoints_security_group_id = module.security_groups.endpoints_security_group_id
  aws_region                  = var.aws_region
}

# -----------------------------------------------------------------------------
# EKS — cluster and managed node group
# -----------------------------------------------------------------------------

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  cluster_version    = var.cluster_version
  cluster_role_arn   = module.iam_roles.eks_cluster_role_arn
  node_role_arn      = module.iam_roles.eks_node_role_arn
  private_subnet_ids = module.subnets.private_subnet_ids
  node_instance_type = var.node_instance_type
  node_desired_count = var.node_desired_count
  node_min_count     = var.node_min_count
  node_max_count     = var.node_max_count
  cluster_admin_arn  = var.cluster_admin_arn

  depends_on = [module.endpoints, module.iam_policies]
}

# -----------------------------------------------------------------------------
# OIDC — shared module for the EKS IRSA and GitHub Actions OIDC providers
# -----------------------------------------------------------------------------

module "oidc" {
  source = "./modules/oidc"

  eks_oidc_issuer_url = module.eks.oidc_issuer_url
  name_prefix         = "${var.project_name}-${var.environment}"
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
# CI/CD IAM roles — IAM roles for GitHub Actions workflows (OIDC-federated)
# -----------------------------------------------------------------------------

module "cicd_iam_roles" {
  source = "./modules/cicd_iam_roles"

  github_org                  = var.github_org
  github_repo                 = var.github_repo
  ecr_repository_arn          = module.ecr.repository_arn
  terraform_state_bucket_arn  = "arn:aws:s3:::${var.project_name}-${var.environment}-tfstate"
  github_actions_provider_arn = module.oidc.github_actions_provider_arn
}

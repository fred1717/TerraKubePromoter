# =============================================================================
# Root-level variables
# =============================================================================

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "terrakubepromoter"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, production)"
  type        = string
  default     = "dev"
}

variable "repository_url" {
  description = "GitHub repository URL for tagging"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
  default     = "1.35"
}

variable "node_instance_type" {
  description = "EC2 instance type for the EKS managed node group"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_count" {
  description = "Desired number of nodes in the managed node group"
  type        = number
  default     = 2
}

variable "node_min_count" {
  description = "Minimum number of nodes in the managed node group"
  type        = number
  default     = 1
}

variable "node_max_count" {
  description = "Maximum number of nodes in the managed node group"
  type        = number
  default     = 3
}

variable "cluster_admin_arn" {
  description = "ARN of the IAM principal granted cluster admin access"
  type        = string
}

variable "vpc_cni_addon_version" {
  description = "Version of the VPC CNI managed addon"
  type        = string
  default     = "v1.21.1-eksbuild.1"
}

variable "availability_zones" {
  description = "List of availability zones the subnets are spread across"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets, paired by index with availability_zones"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets, paired by index with availability_zones"
  type        = list(string)
}

variable "argocd_chart_version" {
  description = "Version of the argo-cd Helm chart from argoproj/argo-helm"
  type        = string
  default     = "9.5.2"
}

variable "argocd_app_version" {
  description = "Version of the ArgoCD application embedded in the chart"
  type        = string
  default     = "v3.3.7"
}

# -----------------------------------------------------------------------------
# GitHub OIDC federation
# -----------------------------------------------------------------------------

variable "github_org" {
  description = "GitHub organisation or user that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

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

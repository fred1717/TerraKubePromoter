# =============================================================================
# EKS module variables
# =============================================================================

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment for resource naming"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for the EKS node group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the cluster and node group"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for the managed node group"
  type        = string
}

variable "node_desired_count" {
  description = "Desired number of nodes in the managed node group"
  type        = number
}

variable "node_min_count" {
  description = "Minimum number of nodes in the managed node group"
  type        = number
}

variable "node_max_count" {
  description = "Maximum number of nodes in the managed node group"
  type        = number
}

variable "cluster_admin_arn" {
  description = "ARN of the IAM principal granted cluster admin access"
  type        = string
}

# =============================================================================
# Inputs for the eks_addons module
# =============================================================================

variable "cluster_name" {
  description = "Name of the EKS cluster the addons attach to"
  type        = string
}

variable "vpc_cni_addon_version" {
  description = "Version of the VPC CNI managed addon (e.g. v1.21.1-eksbuild.1)"
  type        = string
}

variable "enable_network_policy" {
  description = "Enable Kubernetes NetworkPolicy enforcement in the VPC CNI"
  type        = bool
  default     = true
}

# =============================================================================
# Outputs for the eks_addons module
# =============================================================================

output "vpc_cni_addon_arn" {
  description = "ARN of the VPC CNI managed addon"
  value       = aws_eks_addon.vpc_cni.arn
}

output "vpc_cni_addon_version" {
  description = "Active version of the VPC CNI managed addon"
  value       = aws_eks_addon.vpc_cni.addon_version
}

output "network_policy_enabled" {
  description = "Whether NetworkPolicy enforcement is active on the VPC CNI"
  value       = var.enable_network_policy
}

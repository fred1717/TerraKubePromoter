# =============================================================================
# VPC CNI managed addon with NetworkPolicy enforcement
# =============================================================================
# Converts the self-managed VPC CNI installation (default on EKS) into a
# managed addon, allowing configuration via the EKS API.
#
# ENABLE_NETWORK_POLICY=true activates the aws-network-policy-agent container
# inside the aws-node DaemonSet, which enforces Kubernetes NetworkPolicy
# objects via eBPF.
#
# resolve_conflicts_on_create = "OVERWRITE" is required because the VPC CNI
# already exists as a self-managed installation when EKS provisions the
# cluster. Without this, the addon creation would fail on conflict.
# =============================================================================

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = var.cluster_name
  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_addon_version

configuration_values = jsonencode({
    nodeAgent = {
      enabled = var.enable_network_policy
    }
  })

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  tags = {
    Name = "${var.cluster_name}-vpc-cni"
  }
}

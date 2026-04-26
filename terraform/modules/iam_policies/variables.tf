variable "eks_cluster_role_name" {
  description = "Name of the EKS cluster IAM role, target of the cluster policy attachment"
  type        = string
}

variable "eks_node_role_name" {
  description = "Name of the EKS node IAM role, target of the node policy attachments"
  type        = string
}

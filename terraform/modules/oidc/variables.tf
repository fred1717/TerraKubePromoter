variable "eks_oidc_issuer_url" {
  description = "OIDC issuer URL of the EKS cluster, used to create the IRSA provider"
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for the Name tag on the EKS IRSA OIDC provider"
  type        = string
}

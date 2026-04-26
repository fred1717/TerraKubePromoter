variable "vpc_id" {
  description = "ID of the VPC the subnets belong to"
  type        = string
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

variable "name_prefix" {
  description = "Prefix used for the Name tag on each subnet resource"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name, used in the kubernetes.io/cluster/<name> tag"
  type        = string
}

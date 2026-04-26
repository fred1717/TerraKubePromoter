variable "vpc_id" {
  description = "ID of the VPC the security groups belong to"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC, used by ingress rules sourced from inside the VPC"
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for the Name tag on each security group resource"
  type        = string
}

# =============================================================================
# Security groups - shared module for all VPC-level security groups
# =============================================================================

resource "aws_security_group" "endpoints" {
  name        = "${var.name_prefix}-endpoints-sg"
  description = "Allow HTTPS from within the VPC to interface endpoints"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-endpoints-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "endpoints_https" {
  security_group_id = aws_security_group.endpoints.id
  description       = "HTTPS from VPC CIDR"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = var.vpc_cidr

  tags = {
    Name = "${var.name_prefix}-endpoints-https-ingress"
  }
}

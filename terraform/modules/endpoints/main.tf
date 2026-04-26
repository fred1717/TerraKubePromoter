# =============================================================================
# VPC endpoints for private AWS service access
# =============================================================================

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  interface_endpoints = {
    ecr_api = "com.amazonaws.${var.aws_region}.ecr.api"
    ecr_dkr = "com.amazonaws.${var.aws_region}.ecr.dkr"
    sts     = "com.amazonaws.${var.aws_region}.sts"
    eks     = "com.amazonaws.${var.aws_region}.eks"
    logs    = "com.amazonaws.${var.aws_region}.logs"
  }
}

# -----------------------------------------------------------------------------
# Interface endpoints
# -----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "interface" {
  for_each = local.interface_endpoints

  vpc_id              = var.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [var.endpoints_security_group_id]

  tags = {
    Name = "${local.name_prefix}-${each.key}"
  }
}

# -----------------------------------------------------------------------------
# S3 gateway endpoint (free, no per-hour charge)
# -----------------------------------------------------------------------------

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.private_route_table_id]

  tags = {
    Name = "${local.name_prefix}-s3"
  }
}

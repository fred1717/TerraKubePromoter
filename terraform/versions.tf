# =============================================================================
# Terraform and provider version constraints
# =============================================================================
# Terraform: 1.14.8 (latest stable GA as of April 2026)
# AWS provider: ~> 6.40 (latest major version, pinned to 6.x)
# =============================================================================

terraform {
  required_version = ">= 1.14.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.40"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

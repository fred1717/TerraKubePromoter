# =============================================================================
# GitHub OIDC federation — provider and IAM roles for GitHub Actions
# =============================================================================

locals {
  github_oidc_url = "token.actions.githubusercontent.com"
  sub_prefix      = "repo:${var.github_org}/${var.github_repo}"
}

# -----------------------------------------------------------------------------
# Trust policy documents
# -----------------------------------------------------------------------------

data "aws_iam_policy_document" "trust_main_branch" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.github_actions_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_url}:sub"
      values   = ["${local.sub_prefix}:ref:refs/heads/main"]
    }
  }
}

data "aws_iam_policy_document" "trust_production_environment" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.github_actions_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_url}:sub"
      values   = ["${local.sub_prefix}:environment:production"]
    }
  }
}

# -----------------------------------------------------------------------------
# Role 1: gha-ecr-push-role (used by app-ci.yml)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "ecr_push" {
  name               = "gha-ecr-push-role"
  assume_role_policy = data.aws_iam_policy_document.trust_main_branch.json

  tags = {
    Name = "gha-ecr-push-role"
  }
}

data "aws_iam_policy_document" "ecr_push" {
  statement {
    sid     = "EcrAuthorization"
    effect  = "Allow"
    actions = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "EcrPushPull"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:DescribeImages",
      "ecr:DescribeImageScanFindings",
    ]
    resources = [var.ecr_repository_arn]
  }
}

resource "aws_iam_role_policy" "ecr_push" {
  name   = "ecr-push"
  role   = aws_iam_role.ecr_push.id
  policy = data.aws_iam_policy_document.ecr_push.json
}

# -----------------------------------------------------------------------------
# Role 2: gha-terraform-role (used by terraform-ci.yml, production apply only)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "terraform" {
  name               = "gha-terraform-role"
  assume_role_policy = data.aws_iam_policy_document.trust_production_environment.json

  tags = {
    Name = "gha-terraform-role"
  }
}

data "aws_iam_policy_document" "terraform_state" {
  statement {
    sid    = "TerraformStateBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      var.terraform_state_bucket_arn,
      "${var.terraform_state_bucket_arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "terraform_state" {
  name   = "terraform-state"
  role   = aws_iam_role.terraform.id
  policy = data.aws_iam_policy_document.terraform_state.json
}

resource "aws_iam_role_policy_attachment" "terraform_admin" {
  role       = aws_iam_role.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# -----------------------------------------------------------------------------
# Role 3: gha-promote-role (used by promote.yml, production target only)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "promote" {
  name               = "gha-promote-role"
  assume_role_policy = data.aws_iam_policy_document.trust_production_environment.json

  tags = {
    Name = "gha-promote-role"
  }
}

data "aws_iam_policy_document" "promote" {
  statement {
    sid       = "EcrDescribeImagesForDigestLookup"
    effect    = "Allow"
    actions   = ["ecr:DescribeImages"]
    resources = [var.ecr_repository_arn]
  }
}

resource "aws_iam_role_policy" "promote" {
  name   = "promote"
  role   = aws_iam_role.promote.id
  policy = data.aws_iam_policy_document.promote.json
}

#!/usr/bin/env bash
# Exit on error, treat unset variables as errors, fail pipes on first error
set -euo pipefail

github_org=$(terraform -chdir=terraform output -raw github_org)
github_repo=$(terraform -chdir=terraform output -raw github_repo)
repo="${github_org}/${github_repo}"

echo "=== Step 1: default token permissions set to read-only ==="
gh api -X PUT "repos/${repo}/actions/permissions/workflow" -f default_workflow_permissions=read -F can_approve_pull_request_reviews=false

echo
echo "=== Step 2: repository variables ==="
aws_region=$(terraform -chdir=terraform output -raw aws_region)
aws_account_id=$(aws sts get-caller-identity --query Account --output text)
ecr_repository_name=$(terraform -chdir=terraform output -raw ecr_repository_name)
gha_ecr_push_role_arn=$(terraform -chdir=terraform output -raw gha_ecr_push_role_arn)
gha_terraform_role_arn=$(terraform -chdir=terraform output -raw gha_terraform_role_arn)
gha_promote_role_arn=$(terraform -chdir=terraform output -raw gha_promote_role_arn)

gh variable set AWS_REGION --body "${aws_region}"
gh variable set AWS_ACCOUNT_ID --body "${aws_account_id}"
gh variable set ECR_REPOSITORY_NAME --body "${ecr_repository_name}"
gh variable set GHA_ECR_PUSH_ROLE_ARN --body "${gha_ecr_push_role_arn}"
gh variable set GHA_TERRAFORM_ROLE_ARN --body "${gha_terraform_role_arn}"
gh variable set GHA_PROMOTE_ROLE_ARN --body "${gha_promote_role_arn}"

echo
echo "=== Step 3: environments - 3 created, 1 protected ==="
reviewer_user_id=$(gh api "users/${github_org}" --jq .id)

gh api -X PUT "repos/${repo}/environments/dev"
gh api -X PUT "repos/${repo}/environments/staging"

production_env_payload=$(cat <<EOF
{
  "reviewers": [{"type": "User", "id": ${reviewer_user_id}}],
  "prevent_self_review": true,
  "deployment_branch_policy": {"protected_branches": false, "custom_branch_policies": true}
}
EOF
)
echo "${production_env_payload}" | gh api -X PUT "repos/${repo}/environments/production" --input -
gh api -X POST "repos/${repo}/environments/production/deployment-branch-policies" -f name=main

echo
echo "=== Step 4: verification ==="
gh variable list
gh api "repos/${repo}/environments" --jq '.environments[].name'
gh api "repos/${repo}/environments/production" --jq '.protection_rules'

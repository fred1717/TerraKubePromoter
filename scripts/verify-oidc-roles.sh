#!/usr/bin/env bash
# Exit on error, treat unset variables as errors, fail pipes on first error
set -euo pipefail

echo "=== Check 1: OIDC provider exists ==="
query='OpenIDConnectProviderList[?contains(Arn, `token.actions.githubusercontent.com`)].Arn'
aws iam list-open-id-connect-providers --query "${query}" --output json

echo
echo "=== Check 2: each role trust policy scopes the sub claim correctly ==="
for role in gha-ecr-push-role gha-terraform-role gha-promote-role; do
  echo
  echo "--- Role: $role ---"
  query='Role.AssumeRolePolicyDocument.Statement[0].Condition.StringEquals'
  aws iam get-role --role-name "$role" --query "${query}" --output json
done

echo
echo "=== Check 3: each permission policy is resource-scoped ==="
for role in gha-ecr-push-role gha-terraform-role gha-promote-role; do
  echo
  echo "--- Role: $role ---"
  aws iam list-role-policies --role-name "$role" --output json
  aws iam list-attached-role-policies --role-name "$role" --output json
done

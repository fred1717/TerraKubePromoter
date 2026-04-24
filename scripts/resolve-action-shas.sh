#!/usr/bin/env bash
# Exit on error, treat unset variables as errors, fail pipes on first error
set -euo pipefail

echo "=== Resolving SHAs for pinned actions ==="

# Resolves the commit SHA each pinned action version points to.
# Output format: <action> <sha>  # <tag>, ready to paste into .github/workflows/*.yml.

resolve_sha() {
  local action=$1
  local tag=$2
  printf '%-40s %s  # %s\n' "${action}" "$(gh api "repos/${action}/git/refs/tags/${tag}" --jq .object.sha)" "${tag}"
}

echo
echo "--- First-party GitHub actions (pinned to major tag, Decision 6 exception) ---"
resolve_sha actions/checkout         v6
resolve_sha actions/setup-python     v6
resolve_sha actions/upload-artifact  v7
resolve_sha actions/github-script    v9

# Third-party actions: pinned to exact version tag (Decision 6)
resolve_sha aws-actions/configure-aws-credentials v6.1.0
resolve_sha aws-actions/amazon-ecr-login          v2.1.4
resolve_sha docker/setup-buildx-action            v4.0.0
resolve_sha docker/bake-action                    v7.1.0
resolve_sha hashicorp/setup-terraform             v4.0.0

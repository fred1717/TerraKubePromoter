#!/usr/bin/env bash
# Exit on error, treat unset variables as errors, fail pipes on first error
set -euo pipefail

aws_region=$(terraform -chdir=terraform output -raw aws_region)
project_tag_value=$(terraform -chdir=terraform output -raw project_name)

echo "=== Check: every resource carries both a Name tag and the lowercase project tag ==="
filter="Key=project,Values=${project_tag_value}"
query='ResourceTagMappingList[?!(Tags[?Key==`Name`])].ResourceARN'
aws resourcegroupstaggingapi get-resources --region "${aws_region}" --tag-filters "${filter}" --query "${query}" --output json

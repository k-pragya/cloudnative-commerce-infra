#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Running Governance Policy Check (Day 3)..."

cd ~/platform-capstone/cloudnative-commerce-infra/day01/cloudnative-commerce-infra/infrastructure

terraform init >/dev/null
terraform plan -out=tfplan >/dev/null
terraform show -json tfplan > plan.json

cd ~/platform-capstone/cloudnative-commerce-infra/day03/policy

if conftest test --policy . ../../day01/cloudnative-commerce-infra/infrastructure/plan.json; then
    echo "✅ Governance Policy PASSED - Golden Path Compliant"
else
    echo "❌ Governance Policy FAILED"
    exit 1
fi

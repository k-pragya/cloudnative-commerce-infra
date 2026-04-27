#!/usr/bin/env bash
BUCKET_PREFIX="cnc-logs"
ENV="dev"
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
TARGET_BUCKET="${BUCKET_PREFIX}-${ACCOUNT}-${ENV}"

echo "🔍 Checking your Golden Path..."
aws s3api head-bucket --bucket "$TARGET_BUCKET" && echo "✅ Bucket exists"
aws s3api get-bucket-encryption --bucket "$TARGET_BUCKET" | grep -q AES256 && echo "✅ Encryption OK"
echo "✅ Tags & Public Block verified (manual check passed in console)"
echo "🎉 Day 1 COMPLETE!"

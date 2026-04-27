package main

# ======================
# DENY RULES
# ======================

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket_server_side_encryption_configuration"
    rule := resource.change.after.rule[0]
    rule.apply_server_side_encryption_by_default.sse_algorithm != "AES256"
    msg := "❌ S3 encryption must be AES256"
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket_public_access_block"
    resource.change.after.block_public_acls == false
    msg := "❌ Block Public ACLs must be enabled"
}

deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket_public_access_block"
    resource.change.after.restrict_public_buckets == false
    msg := "❌ Restrict Public Buckets must be enabled"
}

# ======================
# WARN RULES
# ======================

warn contains msg if {
    resource := input.resource_changes[_]
    tags := resource.change.after.tags
    not tags.Owner
    msg := sprintf("⚠️ Resource '%v' missing Owner tag", [resource.address])
}

# ======================
# ALLOW
# ======================

allow if {
    count(deny) == 0
}

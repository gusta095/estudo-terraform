include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/security/iam/s3-replication-role"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "gusta-s3-replication"

  origin_bucket_arn      = "arn:aws:s3:::gusta-replication-a-sandbox"
  destination_bucket_arn = "arn:aws:s3:::gusta-replication-b-sandbox"

  s3_policy_replication_statements = [
    {
      sid    = "AllowKMS"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = ["*"]
    }
  ]

  trusted_role_services = [
    "s3.amazonaws.com",
  ]

  tags = local.service_vars.tags
}

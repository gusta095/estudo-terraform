include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/application-integration/sns"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals

  sns_name = "test-sns"
}

inputs = {
  name = local.sns_name

  default_policy_statements = false # Se desativado o topic_policy_statements tem que ser utilizado.

  topic_policy_statements = [
    {
      sid     = "SNSSubscribe"
      effect  = "Allow"
      actions = ["sns:Subscribe"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::${local.account_vars.account_id}:root"] # Permitir só sua conta
        }
      ]
      resources = ["arn:aws:sns:${local.region_vars.aws_region}:${local.account_vars.account_id}:${local.sns_name}"] # O ARN do seu SNS Topic
    }
  ]

  tags = local.service_vars.tags
}

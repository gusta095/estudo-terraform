include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/application-integration/sns"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals

  sns_name = "test-sns"
}

inputs = {
  name = local.sns_name

  subscriptions = [
    {
      protocol = "lambda"
      endpoint = "gusta-lambda" # Nome da Lambda, ou arn
    },
  ]

  topic_policy_statements = [
    {
      sid     = "AllowLambdaPublish"
      effect  = "Allow"
      actions = ["sns:Publish"]
      principals = [
        {
          type        = "Service"
          identifiers = ["lambda.amazonaws.com"]
        }
      ]
      resources = ["arn:aws:sns:${local.region_vars.aws_region}:${local.account_vars.account_id}:${local.sns_name}"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = [local.account_vars.account_id]
        }
      ]
    }
  ]

  tags = local.service_vars.tags
}

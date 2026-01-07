include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/compute/lambda"
  component_version = "25.03.1"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals

  function_name = "gusta-lambda"
}

# O trigger é configurado do lado do SNS por meio da subscription
# no lambda só ajustamos a policy e permissão de trigger

inputs = {
  function_name = local.function_name

  runtime     = "python3.12"
  source_path = ["./code/index.py"]

  allowed_triggers = {
    sns = {
      principal  = "sns.amazonaws.com"
      source_arn = "arn:aws:sns:us-east-1:936943748055:test-sns"
    }
  }

  lambda_policy_statements = [
    {
      sid    = "LambdaSNSPermissions"
      effect = "Allow"
      actions = [
        "sns:Subscribe"
      ]
      resources = ["*"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = [local.account_vars.account_id]
        }
      ]
    },
  ]

  tags = local.service_vars.tags
}

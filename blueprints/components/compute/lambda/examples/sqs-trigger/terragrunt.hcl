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

inputs = {
  function_name = local.function_name

  runtime     = "python3.12"
  source_path = ["./code/index.py"]

  event_source_mapping = [
    {
      event_source_arn = "arn:aws:sqs:us-east-1:936943748055:test-sqs-mensagem"
    },
  ]

  lambda_policy_statements = [
    {
      sid    = "LambdaSQSPermissions"
      effect = "Allow"
      actions = [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
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

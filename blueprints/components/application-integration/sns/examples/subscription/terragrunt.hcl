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
      protocol             = "sqs"
      endpoint             = "meu-sqs" # Nome do SQS, ou arn
      raw_message_delivery = true
    },
    {
      protocol              = "lambda"
      endpoint              = "arn:aws:lambda:us-east-1:123456789012:function:minha-lambda" # Nome da Lambda, ou arn
      subscription_role_arn = "arn:aws:iam::936943748055:role/sns-lambda-role"
    },
    {
      protocol = "firehose"
      endpoint = "meu-firehose" # Nome do Firehose, ou arn
    },
    {
      protocol = "https"
      endpoint = var.webhook_url # Já é uma URL, mantém o valor
    },
    {
      protocol = "email"
      endpoint = var.notification_email # Já é um e-mail, mantém o valor
    },
  ]

  tags = local.service_vars.tags
}

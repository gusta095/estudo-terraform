include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/use-cases/event-driven-message"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "fluxo-core-lab"

  queue_policy_statements = {
    sns = {
      sid     = "SNSPublish"
      actions = ["sqs:SendMessage"]

      principals = [
        {
          type        = "Service"
          identifiers = ["sns.amazonaws.com"]
        }
      ]
    }
  }

  topic_policy_statements = {
    sqs = {
      sid = "SQSSubscribe"
      actions = [
        "sns:Subscribe",
        "sns:Receive",
      ]

      principals = [{
        type        = "AWS"
        identifiers = ["*"]
      }]
    }
  }

  raw_message_delivery = true

  additional_subscriptions = {
    email_subscription = {
      protocol = "email"
      endpoint = "gustavo.gsouza@outlook.com"
    },
  }

  tags = local.service_vars.tags
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/application-integration/sqs"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "test-sqs"

  default_policy_statements = false

  queue_policy_statements = [
    {
      sid     = "SQSPublish"
      actions = ["sqs:SendMessage"]
      effect  = "Allow"
      principals = [
        {
          type = "Service"
          identifiers = [
            "s3.amazonaws.com",
            "sns.amazonaws.com"
          ]
        }
      ]
    },
  ]

  tags = local.service_vars.tags
}

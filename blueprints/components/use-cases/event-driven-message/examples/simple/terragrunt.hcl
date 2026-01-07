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

  sqs_sns = {
    fluxo-test = {
      configs-do-sqs          = "number/string"
      sqs_extra_policy        = "lista(objetos)"
      configs-do-dlq          = "number/string"
      dlq_extra_policy        = "lista(objetos)"
      sns_extra_policy        = "lista(objetos)"
      add-extra-subscriptions = "lista(objetos)"
    }
  }

  tags = local.service_vars.tags
}

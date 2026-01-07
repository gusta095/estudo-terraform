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

  tags = local.service_vars.tags
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/organizations/account-alias"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  account_alias = "exemple-account-alias"
}

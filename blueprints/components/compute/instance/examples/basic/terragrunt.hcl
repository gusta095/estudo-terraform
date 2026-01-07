include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_name    = "components/compute/instance"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "instance-lab"

  public_key = local.account_vars.public_key
  tags       = local.service_vars.tags
}

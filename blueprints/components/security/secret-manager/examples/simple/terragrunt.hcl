include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/security/secret-manager"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "test/gusta"

  secret_string = jsonencode({
    db_user = "admin"
  })

  tags = local.service_vars.tags
}

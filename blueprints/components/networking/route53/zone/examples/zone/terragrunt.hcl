include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/networking/route53/zone"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  zones = {
    "gusta-lab.online" = {
      comment = "Dominio comprado na GoDaddy"
    }
  }

  tags = local.service_vars.tags
}

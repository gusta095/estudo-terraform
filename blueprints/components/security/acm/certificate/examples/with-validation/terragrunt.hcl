include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/security/acm/certificate"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "Certificate for Example domain"

  domain_name = "*.exemplo.com"

  zone_id = local.account_vars.account_route53_zone_id

  tags = local.service_vars.tags
}

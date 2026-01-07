include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = format("%s/shared/vpc", dirname(find_in_parent_folders("region.hcl")))
}

locals {
  component_create  = true
  component_name    = "components/compute/instance"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  name = "atlantis instance"

  user_data = "docker"

  # https://docs.gitlab.com/ee/user/gitlab_com/#ip-range
  additional_ingress_with_cidr_blocks = [
    {
      from_port   = 4141
      to_port     = 4141
      protocol    = "tcp"
      description = "GitLab.com access"
      cidr_blocks = "34.74.226.0/24,34.74.90.64/28"
    },
  ]

  vpc_id            = dependency.vpc.outputs.vpc_id
  public_key        = local.account_vars.public_key
  availability_zone = dependency.vpc.outputs.azs[0]

  tags = local.service_vars.tags
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/containers/ecs/cluster"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  cluster_name = "gusta-ecs-test"

  fargate_capacity_providers = {
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 1
        base   = 2
      }
    }
  }

  tags = local.service_vars.tags
}

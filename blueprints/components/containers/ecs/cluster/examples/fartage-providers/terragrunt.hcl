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
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 3
        base   = 2
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 1
      }
    }
  }

  tags = local.service_vars.tags
}

# Define os provedores de capacidade Fargate para o cluster ECS.
# - As 2 primeiras tarefas sempre serão alocadas no FARGATE.
# - Após isso, para cada 3 tarefas enviadas ao FARGATE, 1 será enviada ao FARGATE_SPOT.
# Isso equilibra custo e disponibilidade, priorizando FARGATE, mas aproveitando FARGATE_SPOT para economia.

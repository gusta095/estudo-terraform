include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/containers/ecs/service"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  cluster_name = "gusta-ecs-test"

  container_definitions = {
    "web-test" = {
      image  = "gusta095/test-web-5000:latest"
      cpu    = 256
      memory = 512
      port_mappings = [
        {
          containerPort = 5000
        }
      ]
    }
  }

  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 3

  tags = local.service_vars.tags
}

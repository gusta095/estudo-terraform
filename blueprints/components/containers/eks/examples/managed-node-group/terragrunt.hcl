include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = format("%s/shared/vpc", dirname(find_in_parent_folders("region.hcl")))
}

locals {
  component_create  = true
  component_name    = "components/containers/eks"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {

  cluster_name    = "gusta-test"
  cluster_version = "1.23"

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 2

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 30
    }
  }

  vpc_id              = dependency.vpc.outputs.vpc_id
  private_subnets_ids = dependency.vpc.outputs.public_subnets # O correto é ser private_subnets, mas por economia está assim

  tags = local.service_vars.tags
}

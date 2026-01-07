# ------------------------------------------------------------------------------
# Tags
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

#------------------------------------------------------------------------------
# Cluster
#------------------------------------------------------------------------------

module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "5.12.0"

  cluster_name = var.cluster_name

  fargate_capacity_providers            = var.fargate_capacity_providers
  default_capacity_provider_use_fargate = var.default_capacity_provider_use_fargate

  cloudwatch_log_group_name              = local.cloudwatch_log_group_name
  cloudwatch_log_group_tags              = local.cloudwatch_log_group_tags
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  tags = module.tags.tags
}

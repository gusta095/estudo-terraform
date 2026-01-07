# ------------------------------------------------------------------------------
# Tags
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

#------------------------------------------------------------------------------
# ALB
#------------------------------------------------------------------------------

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.14.0"

  name = var.alb_name

  internal           = var.internal
  load_balancer_type = var.load_balancer_type

  # networking
  vpc_id        = data.aws_vpc.vpc_infos.id
  subnets       = coalesce(var.subnets, data.aws_subnets.public_subnets.ids)
  target_groups = var.target_groups
  listeners     = var.listeners

  # Security Group
  security_groups              = var.security_groups
  security_group_tags          = local.security_group_tags
  security_group_ingress_rules = var.security_group_ingress_rules
  security_group_egress_rules  = var.security_group_egress_rules

  enable_deletion_protection = var.enable_deletion_protection

  tags = module.tags.tags
}

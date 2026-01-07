# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v1.0.0"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# ZONE
# ------------------------------------------------------------------------------

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.11.1"

  zones = var.zones

  tags = module.tags.tags
}

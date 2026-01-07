# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# SNS
# ------------------------------------------------------------------------------

module "sns" {
  source  = "terraform-aws-modules/sns/aws"
  version = "6.1.2"

  name = var.name

  topic_policy_statements     = local.topic_policy_statements_merged
  enable_default_topic_policy = var.enable_default_topic_policy

  subscriptions = local.resolved_endpoints


  tags = merge(module.tags.tags, { default-policy = local.default_policy })
}

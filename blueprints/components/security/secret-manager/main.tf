# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# Secret Manager
# ------------------------------------------------------------------------------

module "secrets_manager" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.3.1"

  name        = var.name
  description = var.description

  recovery_window_in_days = var.recovery_window_in_days

  # create_policy       = local.create_policy
  # block_public_policy = var.block_public_policy
  # policy_statements   = var.secrets_manager_policy_statements

  secret_string = var.secret_string


  tags = module.tags.tags
}

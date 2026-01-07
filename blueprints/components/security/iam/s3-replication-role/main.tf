# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# S3 Replication Role
# ------------------------------------------------------------------------------

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.54.0"

  name   = "${var.name}-policy"
  policy = data.aws_iam_policy_document.s3_policy.json

  tags = merge(module.tags.tags, { default-policy = local.default_policy })
}

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.54.0"

  role_name   = "${var.name}-role"
  create_role = var.create_role

  role_requires_mfa     = var.role_requires_mfa
  trusted_role_services = var.trusted_role_services

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]

  tags = module.tags.tags
}

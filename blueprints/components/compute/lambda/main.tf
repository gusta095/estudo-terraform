# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# LAMBDA
# ------------------------------------------------------------------------------

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"

  function_name = var.function_name
  description   = var.description
  handler       = var.handler
  runtime       = var.runtime
  architectures = var.architectures

  source_path = var.source_path

  logging_log_group             = local.logging_log_group
  logging_log_format            = var.logging_log_format
  logging_application_log_level = var.logging_application_log_level
  logging_system_log_level      = var.logging_system_log_level

  policy_statements             = local.lambda_policy_statements_merged
  assume_role_policy_statements = var.assume_role_policy_statements
  attach_policy_statements      = var.attach_policy_statements

  attach_cloudwatch_logs_policy      = var.attach_cloudwatch_logs_policy
  attach_create_log_group_permission = var.attach_create_log_group_permission

  event_source_mapping = local.event_source_mapping_merged

  tags = merge(module.tags.tags, { default-policy = local.default_policy })
}

module "alias_no_refresh" {
  source  = "terraform-aws-modules/lambda/aws//modules/alias"
  version = "7.20.1"

  refresh_alias = false

  name = "current-no-refresh"

  function_name    = module.lambda.lambda_function_name
  function_version = module.lambda.lambda_function_version

  allowed_triggers = var.allowed_triggers
}

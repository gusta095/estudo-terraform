# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# SQS
# ------------------------------------------------------------------------------

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.2.1"

  name = var.name

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled

  create_queue_policy     = var.create_queue_policy
  queue_policy_statements = local.queue_policy_statements_merged

  create_dlq = var.create_dlq

  dlq_visibility_timeout_seconds = var.dlq_visibility_timeout_seconds
  dlq_message_retention_seconds  = var.dlq_message_retention_seconds
  dlq_delay_seconds              = var.dlq_delay_seconds
  dlq_receive_wait_time_seconds  = var.dlq_receive_wait_time_seconds
  dlq_sqs_managed_sse_enabled    = var.dlq_sqs_managed_sse_enabled

  create_dlq_queue_policy     = var.create_dlq_queue_policy
  dlq_queue_policy_statements = local.dlq_queue_policy_statements_merged

  fifo_queue = var.fifo_queue

  tags     = merge(module.tags.tags, { default-policy = local.default_policy })
  dlq_tags = merge(module.tags.tags, { default-policy = local.dlq_default_policy })
}

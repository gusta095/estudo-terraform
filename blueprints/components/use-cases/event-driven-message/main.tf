module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}


module "sqs" {
  source = "../../application-integration/sqs"

  name = format("%s-sqs", var.name)

  create_queue_policy     = var.create_queue_policy
  queue_policy_statements = var.queue_policy_statements

  environment = var.environment
  tags        = module.shared_tags.tags
}

module "sns" {
  source = "../../application-integration/sns"

  name = format("%s-sns", var.name)

  create_topic_policy     = var.create_topic_policy
  topic_policy_statements = var.topic_policy_statements

  subscriptions = merge(
    {
      default-sqs = {
        protocol             = "sqs"
        endpoint             = module.sqs.queue_arn
        raw_message_delivery = var.raw_message_delivery
      }
    },
    var.additional_subscriptions
  )

  tags = module.shared_tags.tags
}

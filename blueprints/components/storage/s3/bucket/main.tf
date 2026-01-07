# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# BUCKET
# ------------------------------------------------------------------------------

module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.6.0"

  bucket = "${var.bucket_name}-${var.environment}"
  acl    = var.acl

  restrict_public_buckets = local.restrict_public_buckets
  block_public_acls       = local.block_public_acls
  block_public_policy     = local.block_public_policy
  ignore_public_acls      = local.ignore_public_acls

  control_object_ownership = local.control_object_ownership
  object_ownership         = local.object_ownership

  attach_policy = var.attach_policy
  policy        = data.aws_iam_policy_document.s3_policy.json

  versioning = var.versioning
  website    = var.website

  replication_configuration = var.replication_configuration

  tags = merge(module.tags.tags, { default-policy = local.default_policy })
}

module "sqs_notifications" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "4.6.0"

  count = length(var.sqs_notifications) > 0 ? 1 : 0

  bucket            = module.bucket.s3_bucket_id
  sqs_notifications = local.formatted_sqs_notifications
}

module "sns_notifications" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "4.6.0"

  count = length(var.sns_notifications) > 0 ? 1 : 0

  bucket            = module.bucket.s3_bucket_id
  sns_notifications = local.formatted_sns_notifications
}

module "lambda_notifications" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "4.6.0"

  count = length(var.lambda_notifications) > 0 ? 1 : 0

  bucket               = module.bucket.s3_bucket_id
  lambda_notifications = local.formatted_lambda_notifications
}

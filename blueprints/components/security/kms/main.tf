# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

# ------------------------------------------------------------------------------
# KMS
# ------------------------------------------------------------------------------

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "3.1.1"

  description = "EC2 AutoScaling key usage"
  key_usage   = "ENCRYPT_DECRYPT"

  aliases = ["mycompany/ebs"]

  tags = module.tags.tags
}

# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v1.0.0"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# ACM CERTIFICATE
# ------------------------------------------------------------------------------

locals {
  validate_certificate = length(var.zone_id) > 0
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names

  zone_id              = var.zone_id
  validate_certificate = local.validate_certificate
  validation_method    = "DNS"

  tags = merge(
    module.tags.tags,
    {
      Name = var.name
    }
  )
}

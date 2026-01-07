# ------------------------------------------------------------------------------
# RECORD
# ------------------------------------------------------------------------------

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.11.1"

  zone_name = var.zone_name
  zone_id   = var.account_route53_zone_id

  records = var.records

  private_zone = var.private_zone
}

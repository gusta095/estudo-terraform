# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------

variable "account_route53_zone_id" {
  description = "ID of the account's Route53 zone"
  type        = string
}

# ------------------------------------------------------------------------------
# RECORD
# ------------------------------------------------------------------------------

variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = null
}

variable "private_zone" {
  description = "Whether Route53 zone is private or public"
  type        = bool
  default     = false
}

variable "records" {
  description = "List of objects of DNS records"
  type        = any
  default     = []
}

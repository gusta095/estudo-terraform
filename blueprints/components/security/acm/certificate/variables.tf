# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "tags" {
  description = "Key-value mapping of resource tags"
  type        = map(string)
}

# ------------------------------------------------------------------------------
# ACM CERTIFICATE
# ------------------------------------------------------------------------------

variable "name" {
  description = "The name of the ACM Certificate"
  type        = string
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain the validation record, danger: the zone id must be in the same account of ACM"
  type        = string
  default     = ""
}

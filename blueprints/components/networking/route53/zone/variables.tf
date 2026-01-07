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
# ZONE
# ------------------------------------------------------------------------------

variable "zones" {
  description = "Map of Route53 zone parameters"
  type        = any
  default     = {}
}

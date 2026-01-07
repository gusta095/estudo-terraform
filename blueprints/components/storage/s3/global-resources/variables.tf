# ------------------------------------------------------------------------------
# BUCKET
# ------------------------------------------------------------------------------

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for buckets in this account. Enabling this setting does not affect existing policies or ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for buckets in this account. Enabling this setting does not affect existing bucket policies"
  type        = bool
  default     = true
}

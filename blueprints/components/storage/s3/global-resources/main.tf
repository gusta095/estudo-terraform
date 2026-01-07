# ------------------------------------------------------------------------------
# S3 ACCOUNT PUBLIC ACCESS BLOCK
# ------------------------------------------------------------------------------

resource "aws_s3_account_public_access_block" "s3" {
  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
}

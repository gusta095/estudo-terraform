output "block_public_policy" {
  description = "The block public policy status"
  value       = aws_s3_account_public_access_block.s3.block_public_acls
}

output "block_public_acls" {
  description = "The block public ACLs status"
  value       = aws_s3_account_public_access_block.s3.block_public_policy
}

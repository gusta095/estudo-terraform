output "iam_policy_name" {
  description = "The name of the policy"
  value       = module.iam_policy.name
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.iam_policy.arn
}

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_assumable_role.iam_role_arn
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_assumable_role.iam_role_name
}

# ------------------------------------------------------------------------------
# SNS
# ------------------------------------------------------------------------------

output "topic_arn" {
  description = "O ARN do tópico SNS, como uma propriedade mais óbvia (clone do id)"
  value       = module.sns.topic_arn
}

output "topic_id" {
  description = "O ARN do tópico SNS"
  value       = module.sns.topic_id
}

output "topic_name" {
  description = "O nome do tópico"
  value       = module.sns.topic_name
}

output "topic_owner" {
  description = "O ID da conta AWS do proprietário do tópico SNS"
  value       = module.sns.topic_owner
}

output "subscription_arns" {
  description = "ARNs das subscrições SNS criadas"
  value       = { for k, v in module.sns.subscriptions : k => v.arn }
}

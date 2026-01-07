# ------------------------------------------------------------------------------
# SQS
# ------------------------------------------------------------------------------

output "queue_arn" {
  description = "O ARN da fila SQS"
  value       = module.sqs.queue_arn
}

output "queue_url" {
  description = "A URL da fila SQS criada"
  value       = module.sqs.queue_url
}

output "queue_name" {
  description = "O nome da fila SQS"
  value       = module.sqs.queue_name
}

# ------------------------------------------------------------------------------
# SNS
# ------------------------------------------------------------------------------

output "topic_arn" {
  description = "O ARN do tópico SNS, como uma propriedade mais explícita (clone do ID)"
  value       = module.sns.topic_arn
}

output "topic_id" {
  description = "O ARN do tópico SNS"
  value       = module.sns.topic_id
}

output "topic_name" {
  description = "O nome do tópico SNS"
  value       = module.sns.topic_name
}

output "topic_owner" {
  description = "O ID da conta AWS do proprietário do tópico SNS"
  value       = module.sns.topic_owner
}

output "sns_additional_subscriptions" {
  description = "Lista de assinaturas adicionais do SNS, contendo apenas protocolo e endpoint"
  value       = { for k, v in var.additional_subscriptions : k => { protocol = v.protocol, endpoint = v.endpoint } }
}

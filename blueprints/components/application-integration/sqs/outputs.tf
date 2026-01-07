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
# SQS DLQ
# ------------------------------------------------------------------------------

output "dlq_arn" {
  description = "O ARN da fila DLQ (Dead Letter Queue)"
  value       = module.sqs.dead_letter_queue_arn
}

output "dlq_url" {
  description = "A URL da fila DLQ criada"
  value       = module.sqs.dead_letter_queue_url
}

output "dlq_name" {
  description = "O nome da fila DLQ"
  value       = module.sqs.dead_letter_queue_name
}

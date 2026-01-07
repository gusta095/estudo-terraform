# ------------------------------------------------------------------------------
# LAMBDA
# ------------------------------------------------------------------------------

output "lambda_function_arn" {
  description = "O ARN da Função Lambda"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_name" {
  description = "O nome da Função Lambda"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_version" {
  description = "Última versão publicada da Função Lambda"
  value       = module.lambda.lambda_function_version
}

output "lambda_function_url" {
  description = "A URL da Função Lambda"
  value       = module.lambda.lambda_function_url
}

output "lambda_role_arn" {
  description = "O ARN da role IAM criada para a Função Lambda"
  value       = module.lambda.lambda_role_arn
}

output "lambda_cloudwatch_log_group_arn" {
  description = "ARN do Cloudwatch Log Group"
  value       = module.lambda.lambda_cloudwatch_log_group_arn
}

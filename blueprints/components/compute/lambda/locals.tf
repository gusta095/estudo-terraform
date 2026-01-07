locals {
  logging_log_group = "/aws/lambda/${var.function_name}"

  # Policy padrão.
  default_policy_statements = var.default_policy_statements ? [
    {
      sid    = "LambdaLogging"
      effect = "Allow"
      actions = [
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "logs:CreateLogGroup"
      ]
      resources = [
        "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:${local.logging_log_group}:*:*",
        "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:${local.logging_log_group}:*"
      ]
    },
  ] : []

  # Se o usuário fornecer uma policy personalizadas (lambda_policy_statements), elas serão adicionadas.
  # No entanto, as policy padrão (default_policy_statements) sempre será aplicada.
  lambda_policy_statements_merged = concat(local.default_policy_statements, var.lambda_policy_statements)

  # Cria uma nova lista chamada event_source_mapping_merged, garantindo que todos os objetos da variável
  # `event_source_mapping` contenham a chave `function_name`, preenchenda automaticamente com o ARN da Lambda.
  # Isso é útil para evitar que cada item precise definir `function_name` manualmente.
  event_source_mapping_merged = [
    for event in var.event_source_mapping : merge(event, { function_name = module.lambda.lambda_function_arn })
  ]

  # Indica se a policy padrão está sendo usada.
  default_policy = length(var.lambda_policy_statements) > 0 ? false : true && var.default_policy_statements == true
}

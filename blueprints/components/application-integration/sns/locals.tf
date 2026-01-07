# ------------------------------------------------------------------------------
# Resolução dinâmica de endpoints para assinaturas SNS
# ------------------------------------------------------------------------------
# Este bloco cria um local `resolved_endpoints` que ajusta dinamicamente
# os endpoints das assinaturas SNS, garantindo que os ARNs corretos sejam usados.
#
# Para cada assinatura em `var.subscriptions`, aplicamos a seguinte lógica:
# - Se `endpoint` já for um ARN, usamos diretamente.
# - Caso contrário, verificamos o `protocol` e buscamos o ARN correto usando:
#     - `data.aws_sqs_queue.this[idx].arn` para SQS
#     - `data.aws_lambda_function.this[idx].arn` para Lambda
#     - `data.aws_kinesis_firehose_delivery_stream.this[idx].arn` para Firehose
# - Se o protocolo não exigir um ARN, mantemos o `endpoint` original.
#
# Isso permite que o usuário passe apenas o nome dos recursos ou o ARN diretamente,
# tornando a configuração mais flexível e automatizada.
# ------------------------------------------------------------------------------

locals {
  resolved_endpoints = {
    for idx, v in var.subscriptions : idx => merge(v, {
      endpoint = (
        can(regex("^arn:", v.endpoint)) ? v.endpoint : # Se for ARN, usa diretamente
        v.protocol == "sqs" ? data.aws_sqs_queue.this[idx].arn :
        v.protocol == "lambda" ? data.aws_lambda_function.this[idx].arn :
        v.protocol == "firehose" ? data.aws_kinesis_firehose_delivery_stream.this[idx].arn :
        v.endpoint # Mantém o valor original caso não precise de conversão
      )
    })
  }

  # Se o usuário fornecer uma policy personalizadas (topic_policy_statements), elas serão adicionadas.
  # No entanto, as policy padrão (default_policy_statements) sempre será aplicada.
  topic_policy_statements_merged = concat(local.default_policy_statements, var.topic_policy_statements)

  # Policy padrão que, só será aplicada se a variável `var.default_policy_statements` for verdadeira.
  # Caso contrário, será uma lista vazia.
  default_policy_statements = var.default_policy_statements ? [
    {
      sid    = "DefaultPolicy"
      effect = "Allow"
      principals = [
        {
          type = "Service"
          identifiers = [
            "lambda.amazonaws.com",
            "s3.amazonaws.com",
            "events.amazonaws.com",
            "cloudwatch.amazonaws.com"
          ]
        }
      ]
      actions   = ["sns:Publish"]
      resources = ["arn:aws:sns:${var.aws_region}:${var.account_id}:${var.name}"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = [var.account_id]
        }
      ]
    }
  ] : []

  # Indica se a policy padrão está sendo usada.
  default_policy = length(var.topic_policy_statements) > 0 ? false : true && var.default_policy_statements == true
}

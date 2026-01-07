locals {
  # Se o usuário fornecer uma policy personalizadas (queue_policy_statements), elas serão adicionadas.
  # No entanto, as policy padrão (default_policy_statements) sempre será aplicada.
  queue_policy_statements_merged     = concat(local.default_policy_statements, var.queue_policy_statements)
  dlq_queue_policy_statements_merged = concat(local.dlq_default_policy_statements, var.dlq_queue_policy_statements)

  # Usado para ajustar o nome da fila nas policys
  # Define o nome da fila, adicionando ".fifo" caso seja uma fila FIFO.
  # Define o nome da fila DLQ, adicionando "-dlq.fifo" caso seja uma fila FIFO.
  queue_name     = var.fifo_queue ? "${var.name}.fifo" : var.name
  dlq_queue_name = var.fifo_queue ? "${var.name}-dlq.fifo" : var.name

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
            "sns.amazonaws.com",
            "s3.amazonaws.com",
            "lambda.amazonaws.com"
          ]
        }
      ]
      actions = [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]
      resources = ["arn:aws:sqs:${var.aws_region}:${var.account_id}:${local.queue_name}"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = [var.account_id]
        }
      ]
    },
  ] : []

  # Policy padrão para a DLQ.
  dlq_default_policy_statements = var.dlq_default_policy_statements ? [
    {
      sid    = "DefaultPolicy"
      effect = "Allow"
      principals = [
        {
          type = "Service"
          identifiers = [
            "sqs.amazonaws.com",
            "lambda.amazonaws.com",
            "events.amazonaws.com"
          ]
        }
      ]
      actions   = ["sqs:SendMessage"]
      resources = ["arn:aws:sqs:${var.aws_region}:${var.account_id}:${local.dlq_queue_name}"]
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
  default_policy     = length(var.queue_policy_statements) > 0 ? false : true && var.default_policy_statements == true
  dlq_default_policy = length(var.dlq_queue_policy_statements) > 0 ? false : true && var.dlq_default_policy_statements == true
}

# Esse bloco permite a criação de políticas IAM altamente flexíveis para buckets S3,
# garantindo que todas as regras sejam definidas dinamicamente conforme necessário,
# sem exigir modificações manuais no código.

data "aws_iam_policy_document" "s3_policy" {
  dynamic "statement" {
    for_each = local.s3_policy_statements_merged

    content {
      sid           = try(statement.value.sid, "")
      actions       = try(statement.value.actions, [])
      not_actions   = try(statement.value.not_actions, [])
      effect        = try(statement.value.effect, "Deny")
      resources     = try(statement.value.resources, [])
      not_resources = try(statement.value.not_resources, [])

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = try(principals.value.type, "AWS")
          identifiers = try(principals.value.identifiers, [])
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = try(not_principals.value.type, "AWS")
          identifiers = try(not_principals.value.identifiers, [])
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = try(condition.value.test, "")
          values   = try(condition.value.values, [])
          variable = try(condition.value.variable, "")
        }
      }
    }
  }
}

# Busca dinamicamente o ARN do SQS/SNS apenas quando o usuário fornece o nome,
# evitando buscas desnecessárias caso um ARN já tenha sido informado.
# Isso permite maior flexibilidade na configuração e simplifica o uso do módulo.

data "aws_sqs_queue" "sqs_arns" {
  for_each = {
    for k, v in var.sqs_notifications : k => v
    if !can(regex("^arn:aws:sqs", v.queue_name)) # Só busca se for um nome (não um ARN)
  }
  name = each.value.queue_name
}

data "aws_sns_topic" "sns_arns" {
  for_each = {
    for k, v in var.sns_notifications : k => v
    if !can(regex("^arn:aws:sns", v.topic_name)) # Só busca se for um nome (não um ARN)
  }
  name = each.value.topic_name
}

# Buscar ARN apenas quando não receber um function_arn
data "aws_lambda_function" "lambda_arns" {
  for_each = {
    for k, v in var.lambda_notifications : k => v if v.function_arn == null
  }
  function_name = each.value.function_name
}

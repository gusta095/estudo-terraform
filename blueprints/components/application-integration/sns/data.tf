# ------------------------------------------------------------------------------
# Resolução automática de ARNs para assinaturas SNS
# ------------------------------------------------------------------------------
# Este bloco de código cria data sources dinamicamente para obter o ARN
# dos serviços SQS, Lambda e Firehose quando o usuário passa apenas o nome.
#
# Para cada tipo de serviço, verificamos:
#  - Se a assinatura é do tipo correspondente (SQS, Lambda ou Firehose)
#  - Se o endpoint fornecido NÃO é um ARN (usa regex "^arn:" para checar)
#
# Caso essas condições sejam atendidas, o Terraform busca o ARN correto
# automaticamente, permitindo que o usuário passe apenas o nome do recurso.
#
# Se o usuário já forneceu um ARN diretamente, o data source não é criado,
# evitando chamadas desnecessárias à AWS.
#
# Isso melhora a flexibilidade e simplifica a configuração das assinaturas SNS.
# ------------------------------------------------------------------------------

data "aws_sqs_queue" "this" {
  for_each = { for idx, v in var.subscriptions : idx => v if v.protocol == "sqs" && !can(regex("^arn:", v.endpoint)) }

  name = each.value.endpoint
}

data "aws_lambda_function" "this" {
  for_each = { for idx, v in var.subscriptions : idx => v if v.protocol == "lambda" && !can(regex("^arn:", v.endpoint)) }

  function_name = each.value.endpoint
}

data "aws_kinesis_firehose_delivery_stream" "this" {
  for_each = { for idx, v in var.subscriptions : idx => v if v.protocol == "firehose" && !can(regex("^arn:", v.endpoint)) }

  name = each.value.endpoint
}

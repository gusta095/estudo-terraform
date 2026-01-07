locals {
  # Se a variável `control_object_ownership` for definida como true, utilizamos esse valor.
  # Caso contrário, seguimos a lógica baseada na ACL.
  control_object_ownership = var.control_object_ownership || (var.acl == "private")

  # Quando a ACL for "private", definimos "ObjectWriter".
  # Caso contrário, usamos um valor padrão ("BucketOwnerEnforced").
  object_ownership = var.acl == "private" ? "ObjectWriter" : var.object_ownership

  # Constrói um novo mapa `formatted_sqs_notifications` garantindo compatibilidade com o módulo S3.
  # Se o usuário fornecer um ARN diretamente, ele será utilizado. Caso contrário, o ARN será obtido dinamicamente
  # com base no nome da fila informada.
  formatted_sqs_notifications = {
    for k, v in var.sqs_notifications : k => {
      queue_arn     = can(regex("^arn:aws:sqs", v.queue_name)) ? v.queue_name : data.aws_sqs_queue.sqs_arns[k].arn # Só busca se for um nome (não um ARN)
      events        = v.events
      filter_prefix = v.filter_prefix
      filter_suffix = v.filter_suffix
    }
  }

  formatted_sns_notifications = {
    for k, v in var.sns_notifications : k => {
      topic_arn     = can(regex("^arn:aws:sns", v.topic_name)) ? v.topic_name : data.aws_sns_topic.sns_arns[k].arn # Só busca se for um nome (não um ARN)
      events        = v.events
      filter_prefix = v.filter_prefix
      filter_suffix = v.filter_suffix
    }
  }

  # Preenche function_arn automaticamente se não for fornecido pelo usuário
  formatted_lambda_notifications = {
    for k, v in var.lambda_notifications : k => merge(v, {
      function_arn = v.function_arn != null ? v.function_arn : lookup(data.aws_lambda_function.lambda_arns, k, null).arn
    })
  }

  # Política padrão
  default_policy_statements = var.default_policy_statements ? [
    {
      sid    = "DefaultPolicy"
      effect = "Allow"
      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::${var.account_id}:root",
            "arn:aws:iam::${var.account_id}:user/terraform-user",
          ]
        }
      ]
      actions = [
        "s3:*"
      ]
      resources = [
        "arn:aws:s3:::${var.bucket_name}-${var.environment}",
        "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
      ]
    }
  ] : []

  # Se o usuário fornecer uma policy personalizadas (s3_policy_statements), elas serão adicionadas.
  # No entanto, as policy padrão (default_policy_statements) sempre será aplicada.
  s3_policy_statements_merged = concat(local.default_policy_statements, var.s3_policy_statements)

  # Indica se a  policy padrão está usando usada.
  default_policy = length(var.s3_policy_statements) > 0 ? false : true && var.default_policy_statements == true

  # Se "access_public_bucket" estiver ativado (true), todos os controles de acesso público serão forçados para "false",
  # garantindo que todo acesso público seja permitido.
  # Caso contrário, cada configuração individual manterá o valor definido no default.
  restrict_public_buckets = var.access_public_bucket ? false : var.restrict_public_buckets
  block_public_acls       = var.access_public_bucket ? false : var.block_public_acls
  block_public_policy     = var.access_public_bucket ? false : var.block_public_policy
  ignore_public_acls      = var.access_public_bucket ? false : var.ignore_public_acls

  valid_s3_events = [
    "s3:ReducedRedundancyLostObject",
    "s3:ObjectCreated:*",
    "s3:ObjectCreated:Put",
    "s3:ObjectCreated:Post",
    "s3:ObjectCreated:Copy",
    "s3:ObjectCreated:CompleteMultipartUpload",
    "s3:ObjectRemoved:*",
    "s3:ObjectRemoved:Delete",
    "s3:ObjectRemoved:DeleteMarkerCreated",
    "s3:ObjectRestore:Post",
    "s3:ObjectRestore:Completed",
    "s3:Replication:OperationFailedReplication",
    "s3:Replication:OperationMissedThreshold",
    "s3:Replication:OperationReplicatedAfterThreshold",
    "s3:ObjectRestore:Delete",
    "s3:LifecycleExpiration:*",
    "s3:LifecycleExpiration:Delete",
    "s3:LifecycleExpiration:DeleteMarkerCreated",
    "s3:LifecycleTransition",
    "s3:IntelligentTiering",
    "s3:ObjectAcl:Put",
    "s3:StorageLensAggregation:CreateReport"
  ]
}

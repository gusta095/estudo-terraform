locals {
  default_policy_replication_statements = var.default_policy_replication_statements ? [
    {
      sid    = "AllowOriginBucketAccess"
      effect = "Allow"
      actions = [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionTagging",
        "s3:GetReplicationConfiguration",
        "s3:GetBucketVersioning",
        "s3:ListBucket"
      ]
      resources = [
        var.origin_bucket_arn,
        "${var.origin_bucket_arn}/*"
      ]
    },
    {
      sid    = "AllowDestinationBucketAccess"
      effect = "Allow"
      actions = [
        "s3:ObjectOwnerOverrideToBucketOwner",
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags",
        "s3:PutObjectAcl"
      ]
      resources = [
        var.destination_bucket_arn,
        "${var.destination_bucket_arn}/*"
      ]
    }
  ] : []

  # Se o usuário fornecer uma policy personalizadas (s3_policy_statements), elas serão adicionadas.
  # No entanto, as policy padrão (default_policy_statements) sempre será aplicada.
  s3_policy_statements_merged = concat(local.default_policy_replication_statements, var.s3_policy_replication_statements)

  # Indica se a policy padrão está sendo usada.
  default_policy = length(var.s3_policy_replication_statements) > 0 ? false : true && var.default_policy_replication_statements == true
}

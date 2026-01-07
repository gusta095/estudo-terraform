include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/storage/s3/bucket"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals

  bucket_name = "gusta-teste-mensagem" # bucket-name sem o environment
}

inputs = {
  bucket_name = local.bucket_name

  default_policy_statements = false # Se desativado o topic_policy_statements tem que ser utilizado.

  s3_policy_statements = [
    {
      sid    = "S3GetObject"
      effect = "Allow"
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::${local.account_vars.account_id}:root"]
        }
      ]
      actions = ["s3:GetObject"]
      resources = [
        "arn:aws:s3:::${local.bucket_name}-${local.account_vars.environment}",  # Libera acesso ao próprio bucket
        "arn:aws:s3:::${local.bucket_name}-${local.account_vars.environment}/*" # Libera acesso todos os objetos dentro dele
      ]
    }
  ]

  tags = local.service_vars.tags
}

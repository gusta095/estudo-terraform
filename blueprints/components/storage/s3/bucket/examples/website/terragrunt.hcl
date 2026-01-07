include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/s3/bucket"
  component_version = "CHANGEME"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals

  bucket_name = "gusta-teste-mensagem" # bucket-name sem o environment
}

inputs = {
  bucket_name = local.bucket_name

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  access_public_bucket = true

  s3_policy_statements = [
    {
      sid    = "S3WebSite"
      effect = "Allow"
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"] # todo mundo
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

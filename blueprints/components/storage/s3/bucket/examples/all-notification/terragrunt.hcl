include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/storage/s3/bucket"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals

  bucket_name = "gusta-teste-mensagem" # bucket-name sem o environment
}

inputs = {
  bucket_name = local.bucket_name

  sqs_notifications = {
    sqs1 = {
      queue_name    = "test-sqs-mensagem"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "teste/"
      filter_suffix = ""
    },
  }

  sns_notifications = {
    sns1 = {
      topic_name    = "test-sns-mensagem"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "prefix/"
      filter_suffix = ".csv"
    },
  }

  lambda_notifications = {
    lambda1 = {
      function_name = module.lambda_function1.lambda_function_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "prefix/"
      filter_suffix = ".json"
    },
    lambda2 = {
      function_arn  = module.lambda_function1.lambda_function_arn # uso opcional
      function_name = module.lambda_function1.lambda_function_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "prefix/"
      filter_suffix = ".json"
    },
    lambda3 = {
      function_arn  = module.lambda_function2.lambda_function_arn # uso opcional
      function_name = module.lambda_function2.lambda_function_name
      events        = ["s3:ObjectCreated:Post"]
    }
  }

  # A policy do S3 não precisa de permissões específicas para enviar eventos para o SQS,
  # Quem precisa da policy correta é o SQS.

  tags = local.service_vars.tags
}

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

  lambda_notifications = {
    lambda-Test = {
      function_name = "gusta-lambda"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "lambda-test/"
      filter_suffix = ".json"
    },
    lambda-Test-2 = {
      function_arn  = "arn:aws:lambda:us-east-1:936943748055:function:gusta-test" # uso opcional
      function_name = "gusta-test"
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "lambda-test/"
      filter_suffix = ".json"
    },
  }

  tags = local.service_vars.tags
}

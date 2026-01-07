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

  acl = "private"

  tags = local.service_vars.tags
}

# Não usa ACLs, seguindo a recomendação da AWS,pois ACLs são consideradas
# obsoletas para controle de acesso em buckets S3 modernos.
# https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/about-object-ownership.html

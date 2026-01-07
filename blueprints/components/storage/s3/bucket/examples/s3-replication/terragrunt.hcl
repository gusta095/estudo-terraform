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

  versioning = {
    enabled = true
  }

  replication_configuration = {
    role = "arn:aws:iam::936943748055:role/gusta-s3-replication-role"

    rules = [
      {
        id       = "replication-test"
        status   = true
        priority = 0

        filter = {
          prefix = "transfer"
        }

        destination = {
          bucket        = "arn:aws:s3:::gusta-replication-b-sandbox"
          storage_class = "STANDARD"
        }

        delete_marker_replication = false
      },
    ]
  }

  tags = local.service_vars.tags
}

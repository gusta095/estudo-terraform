include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/compute/lambda"
  component_version = "25.03.1"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  function_name = "gusta-lambda"

  runtime     = "python3.12"
  source_path = ["./code/index.py"]

  tags = local.service_vars.tags
}

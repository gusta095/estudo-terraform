locals {
  component_create  = true
  component_name    = "aws/s3/global-resources"
  component_version = "CHANGEME"
}

include {
  path = find_in_parent_folders("root.hcl")
}

# NOTE: this component does not require any inputs
inputs = {}

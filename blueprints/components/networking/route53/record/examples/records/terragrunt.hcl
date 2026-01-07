include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/networking/route53/record"
  component_version = "CHANGEME"
}

inputs = {
  records = [
    {
      name = "*"
      type = "CNAME"
      ttl  = 300
      records = [
        "test.example.com",
      ]
    },
  ]
}

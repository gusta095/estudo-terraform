data "aws_vpc" "vpc_infos" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Obtém todas as subnets públicas na VPC
data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_infos.id]
  }

  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
}

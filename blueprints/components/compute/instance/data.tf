# ------------------------------------------------------------------------------
# DATA SOURCES
# ------------------------------------------------------------------------------

data "aws_vpc" "vpc_infos" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_region" "current" {}

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

# Obtém a subnet pública específica na AZ "a"
data "aws_subnet" "public_az_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_infos.id]
  }

  filter {
    name   = "availability-zone"
    values = ["${data.aws_region.current.name}a"]
  }

  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
}

# Obtém a AMI mais recente do Ubuntu Server AMD64
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

# Obtém o IP público da máquina de onde o Terraform está sendo executado
data "http" "myip" {
  url = "https://checkip.amazonaws.com/"
}

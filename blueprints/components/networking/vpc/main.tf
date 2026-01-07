# ------------------------------------------------------------------------------
# LOCALS
# ------------------------------------------------------------------------------

# Referencia para a criação de subnets privadas e públicas - ipcalc 10.0.0.0/16 21

locals {
  # cidr (e.g. for '10.0.0.0/16'):
  # Subnets publicas de uso geral
  public_subnet_cidrs = [
    cidrsubnet(var.cidr, 5, 0), # e.g. 10.0.0.0/21
    cidrsubnet(var.cidr, 5, 1), # e.g. 10.0.8.0/21
    cidrsubnet(var.cidr, 5, 2), # e.g. 10.0.16.0/21
    cidrsubnet(var.cidr, 5, 3), # e.g. 10.0.24.0/21
    cidrsubnet(var.cidr, 5, 4), # e.g. 10.0.32.0/21
  ]
  # Subnets privadas de uso geral
  private_subnet_cidrs = [
    cidrsubnet(var.cidr, 5, 5), # e.g. 10.0.40.0/21
    cidrsubnet(var.cidr, 5, 6), # e.g. 10.0.48.0/21
    cidrsubnet(var.cidr, 5, 7), # e.g. 10.0.56.0/21
    cidrsubnet(var.cidr, 5, 8), # e.g. 10.0.64.0/21
    cidrsubnet(var.cidr, 5, 9), # e.g. 10.0.72.0/21
  ]

  # Número de AZs utilizadas por região
  number_of_azs_per_region = {
    us-east-1 = 5
    us-east-2 = 3
    sa-east-1 = 3
  }

  number_of_azs = local.number_of_azs_per_region[var.aws_region]

  # Filtro de CIDRs de acordo com o número de AZs disponível
  # Por exemplo, em Ohio (3 AZs), os 2 últimos CIDRs da lista serão descartados
  public_subnets  = slice(local.public_subnet_cidrs, 0, local.number_of_azs)
  private_subnets = slice(local.private_subnet_cidrs, 0, local.number_of_azs)
}


# ------------------------------------------------------------------------------
# TAGS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v1.0.0"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# DATA SOURCES
# ------------------------------------------------------------------------------

data "aws_availability_zones" "available" {
  state = "available"
}

# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.name
  cidr = var.cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  map_public_ip_on_launch = true

  private_subnet_tags = {
    subnet-type = "private"
  }

  public_subnet_tags = {
    subnet-type = "public"
  }

  manage_default_security_group = true

  default_security_group_ingress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      self        = true
      description = "Default security group"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = var.cidr
      description = "VPC CIDR"
    },
  ]

  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all"
    },
  ]

  tags = module.tags.tags
}

# ------------------------------------------------------------------------------
# LOCALS
# ------------------------------------------------------------------------------

locals {
  install = {
    "gitlab-runner" = "./user-data/gitlab-runner.sh"
    "docker"        = "./user-data/docker.sh"
    "minikube"      = "./user-data/minikube.sh"
  }
}

# ------------------------------------------------------------------------------
# TAGSS
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v1.0.0"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# IAM ROLE / INSTANCE PROFILE
# ------------------------------------------------------------------------------

module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.37.1"

  create_role             = var.create_role
  create_instance_profile = var.create_instance_profile

  role_name         = format("%s-iam-role", var.name)
  role_description  = format("IAM role the instance %s", var.name)
  role_requires_mfa = var.role_requires_mfa

  trusted_role_services = [
    "ec2.amazonaws.com",
  ]

  attach_admin_policy = true

  tags = module.tags.tags
}

# ------------------------------------------------------------------------------
# SECURITY GROUP
# ------------------------------------------------------------------------------

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = format("%s-security-group", var.name)
  description = format("Security group the instance %s", var.name)
  vpc_id      = coalesce(var.vpc_id, data.aws_vpc.vpc_infos.id)

  ingress_rules       = var.ingress_rules
  ingress_cidr_blocks = var.ingress_cidr_blocks

  ingress_with_cidr_blocks = flatten([
    [
      {
        rule        = "ssh-tcp"
        description = "SSH"
        cidr_blocks = format("%s/32", chomp(data.http.myip.response_body))
      },
    ],
    var.additional_ingress_with_cidr_blocks,
  ])

  ingress_with_self = [
    {
      rule        = "all-all"
      description = "Self"
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      description = "Allow all"
    },
  ]

  tags = module.tags.tags
}

# ------------------------------------------------------------------------------
# KEY PAIR
# ------------------------------------------------------------------------------

resource "aws_key_pair" "this" {
  key_name   = format("%s-key-pair", var.name)
  public_key = var.public_key
}

# ------------------------------------------------------------------------------
# EC2 INSTANCE
# ------------------------------------------------------------------------------

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = var.name

  ami           = coalesce(var.ami, data.aws_ami.ubuntu.image_id)
  instance_type = var.instance_type

  subnet_id         = data.aws_subnet.public_az_a.id
  availability_zone = coalesce(var.availability_zone, data.aws_subnet.public_az_a.availability_zone)

  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [module.security_group.security_group_id, ]
  iam_instance_profile   = module.iam_role.iam_instance_profile_name

  root_block_device = [
    {
      encrypted   = var.root_volume_encrypted
      throughput  = var.root_volume_throughput
      volume_type = var.root_volume_type
      volume_size = var.root_volume_size
    }
  ]

  user_data = try(file(local.install[var.user_data]), null)

  tags = module.tags.tags
}

### teste

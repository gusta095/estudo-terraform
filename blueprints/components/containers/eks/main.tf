# ------------------------------------------------------------------------------
# Locals
# ------------------------------------------------------------------------------


locals {
  fixed_node_group_policy = {
    AutoScalingFullAccess   = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
    AmazonRoute53FullAccess = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  }

  # Itera sobre cada par de chave-valor no mapa de objetos var.eks_managed_node_groups,
  # mescla o valor de cada objeto com o objeto local.fixed_node_group_policy
  # desta forma o local.eks_managed_node_groups é merge de um merge dos valores fixos e variáveis.
  eks_managed_node_groups = {
    for key, value in var.eks_managed_node_groups : key => merge(
      value,
      {
        iam_role_additional_policies = local.fixed_node_group_policy # merge(value.iam_role_additional_node_group_policies, local.fixed_node_group_policy)
      }
    )
  }
}

# ------------------------------------------------------------------------------
# Tags
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v1.0.0"

  environment = var.environment

  tags = var.tags
}

# ------------------------------------------------------------------------------
# EKS
# ------------------------------------------------------------------------------

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  vpc_id     = var.vpc_id
  subnet_ids = slice(var.private_subnets_ids, 0, 3)

  cluster_encryption_config = var.cluster_encryption_config
  cluster_enabled_log_types = var.cluster_enabled_log_types

  authentication_mode     = var.authentication_mode
  eks_managed_node_groups = local.eks_managed_node_groups

  cluster_addons = var.cluster_addons
  access_entries = var.access_entries

  tags = module.tags.tags
}

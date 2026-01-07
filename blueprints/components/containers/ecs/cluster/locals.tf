locals {
  # Nome personalizado do grupo de logs do CloudWatch para o cluster ECS.
  cloudwatch_log_group_name = "/aws/ecs-cluster/${var.cluster_name}"

  # Mapa de tags para serem adicionadas ao grupo de logs criado.
  cloudwatch_log_group_tags = module.tags.tags
}

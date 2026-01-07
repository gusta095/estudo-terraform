#------------------------------------------------------------------------------
# ECS Cluster
#------------------------------------------------------------------------------

output "cluster_name" {
  description = "Name that identifies the cluster"
  value       = module.ecs_cluster.name
}

output "cluster_arn" {
  description = "ARN that identifies the cluster"
  value       = module.ecs_cluster.arn
}

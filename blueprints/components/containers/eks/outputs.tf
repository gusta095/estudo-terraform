# ------------------------------------------------------------------------------
# EKS Cluster
# ------------------------------------------------------------------------------

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = module.eks.cluster_version
}

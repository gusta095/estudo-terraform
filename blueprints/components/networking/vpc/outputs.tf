# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "The VPC name"
  value       = module.vpc.name
}

output "vpc_cidr_block" {
  description = "The VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "azs" {
  description = "The list of eligible AZs for provisioning the VPC subnets"
  value       = module.vpc.azs
}

output "default_security_group_id" {
  description = "The default security group ID"
  value       = module.vpc.default_security_group_id
}

output "private_subnets" {
  description = "List of the VPC private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of the VPC public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of the VPC private subnet CIDRs"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "List of the VPC public subnet CIDRs"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_route_table_ids" {
  description = "The private route table IDs"
  value       = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  description = "The public route table IDs"
  value       = module.vpc.public_route_table_ids
}

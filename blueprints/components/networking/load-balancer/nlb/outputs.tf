output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.vpc_infos.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de subnets publicas"
  value       = data.aws_subnets.public_subnets.ids
}

output "arn" {
  description = "ARN do Load Balancer criado."
  value       = module.nlb.arn
}

output "dns_name" {
  description = "Nome DNS do Load Balancer, usado para acessá-lo diretamente."
  value       = module.nlb.dns_name
}

output "listeners" {
  description = "Mapa dos listeners criados e seus atributos."
  value       = module.nlb.listeners
}

output "listener_rules" {
  description = "Mapa das regras de listeners criadas e seus atributos."
  value       = module.nlb.listener_rules
}

output "target_groups" {
  description = "Mapa dos target groups criados e seus atributos."
  value       = module.nlb.target_groups
}

output "security_group_arn" {
  description = "ARN (Amazon Resource Name) do Security Group associado ao Load Balancer."
  value       = module.nlb.security_group_arn
}

output "security_group_id" {
  description = "ID do Security Group associado ao Load Balancer."
  value       = module.nlb.security_group_id
}

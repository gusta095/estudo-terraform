# Busca o ARN do Application Load Balancer (ALB) com base no nome fornecido
data "aws_lb" "alb_arn" {
  count = var.ecs_worker ? 0 : 1

  name = var.alb_name
}

# Obtém o ID do Security Group associado ao ALB
# A expressão abaixo verifica se a lista de security groups do ALB contém elementos e, em caso positivo, acessa o primeiro SG.
# 'count.index' é usado para acessar o ALB correspondente (quando count > 0).
data "aws_security_group" "alb_sg" {
  count = var.ecs_worker ? 0 : 1

  id = length(data.aws_lb.alb_arn) > 0 ? tolist(data.aws_lb.alb_arn[count.index].security_groups)[0] : null
}

# Obtém informações do cluster ECS pelo nome
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.cluster_name
}

# Obtém informações da VPC com base no nome da tag
data "aws_vpc" "vpc_infos" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_primary_name]
  }
}

# Obtém todas as subnets públicas dentro da VPC especificada
data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_infos.id]
  }

  # Filtra apenas as subnets marcadas como "public"
  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
}

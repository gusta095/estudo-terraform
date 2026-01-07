# ------------------------------------------------------------------------------
# Tags
# ------------------------------------------------------------------------------

module "tags" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git?ref=v2.0.0"

  environment = var.environment
  tags        = var.tags
}

#------------------------------------------------------------------------------
# Service
#------------------------------------------------------------------------------

module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "5.12.0"

  name = "${local.container_name}-task-definition"

  cluster_arn    = data.aws_ecs_cluster.ecs_cluster.arn
  create_service = var.create_service
  desired_count  = var.desired_count

  cpu    = local.cpu
  memory = local.memory

  container_definitions = local.container_definitions

  # Configuração automática do Load Balancer
  load_balancer = var.ecs_worker ? var.load_balancer : {
    service = {
      target_group_arn = aws_lb_target_group.this[0].arn
      container_name   = local.container_name
      container_port   = local.container_port
    }
  }

  subnet_ids       = data.aws_subnets.public_subnets.ids
  assign_public_ip = var.assign_public_ip

  # Definição dinâmica de regras do Security Group
  security_group_rules = local.security_group_rules

  enable_autoscaling       = var.enable_autoscaling
  autoscaling_policies     = var.autoscaling_policies
  autoscaling_min_capacity = var.autoscaling_min_capacity
  autoscaling_max_capacity = var.autoscaling_max_capacity

  tags = module.tags.tags
}
#------------------------------------------------------------------------------
# Target Group/Listener
#------------------------------------------------------------------------------

resource "aws_lb_target_group" "this" {
  for_each = var.ecs_worker ? {} : var.container_definitions

  name        = "${each.key}-target-group"
  port        = each.value.port_mappings.hostPort
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc_infos.id
  target_type = "ip"

  health_check {
    path = "/"
  }

  tags = module.tags.tags
}

resource "aws_lb_listener" "http_listener" {
  count = var.ecs_worker ? 0 : 1

  load_balancer_arn = data.aws_lb.alb_arn[count.index].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  count = var.ecs_worker ? 0 : 1

  load_balancer_arn = data.aws_lb.alb_arn[count.index].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = "arn:aws:acm:us-east-1:936943748055:certificate/dcd48fa2-d3a6-4562-b4f1-11e17b043b22"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[count.index].arn
  }
}

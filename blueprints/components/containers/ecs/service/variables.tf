# ------------------------------------------------------------------------------
# GLOBAL
# ------------------------------------------------------------------------------

variable "environment" {
  description = "O nome do ambiente"
  type        = string
}

variable "tags" {
  description = "Mapeamento de chave-valor para tags dos recursos"
  type        = map(string)
}

variable "vpc_primary_name" {
  description = "Nome da VPC principal que será utilizada na região"
  type        = string
}

# ------------------------------------------------------------------------------
# ECS Service
# ------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Nome do cluster ECS"
  type        = string
}

variable "alb_name" {
  description = "Alb name"
  type        = string
  default     = null
}

variable "desired_count" {
  description = "Número de instâncias da definição de tarefa a serem criadas e mantidas em execução"
  type        = number
  default     = 1
}

variable "create_service" {
  description = "Determina se o recurso do serviço será criado"
  type        = bool
  default     = true
}

variable "assign_public_ip" {
  description = "Define se um endereço IP público será atribuído à ENI (somente para o tipo de execução Fargate)"
  type        = bool
  default     = true
}

variable "ssl_policy" {
  description = "Política de segurança SSL/TLS para o listener do Load Balancer"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"

  validation {
    condition     = contains(local.valid_ssl_policys, var.ssl_policy)
    error_message = "A política SSL informada não é válida, na lista local.valid_ssl_policys"
  }
}

variable "load_balancer" {
  description = "Bloco de configuração para balanceadores de carga"
  type        = any
  default     = {}
}

variable "ecs_worker" {
  description = "flag para ativar e desativar o modo worker"
  type        = bool
  default     = true
}

variable "container_definitions" {
  description = "Um mapa de definições de contêiner usadas pelo Amazon ECS"
  type = map(object({
    image     = string
    cpu       = optional(number, 256)
    memory    = optional(number, 512)
    essential = optional(bool, true)
    port_mappings = optional(list(object({
      name          = optional(string)
      containerPort = number
      # hostPort      = optional(number, 0)
      protocol = optional(string, "tcp")
    })), [])
  }))
  default = {}
}

variable "enable_autoscaling" {
  description = "Enables or disables autoscaling for the service."
  type        = bool
  default     = true
}

variable "autoscaling_min_capacity" {
  description = "The minimum number of tasks that should be running in the service."
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "The maximum number of tasks that can run in the service."
  type        = number
  default     = 2
}

variable "autoscaling_policies" {
  description = "Defines the autoscaling policies for the service."
  type        = any
  default = {
    cpu = {
      policy_type = "TargetTrackingScaling"

      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
        scale_in_cooldown  = 300
        scale_out_cooldown = 60
        target_value       = 90
      }
    }
    memory = {
      policy_type = "TargetTrackingScaling"

      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }
        scale_in_cooldown  = 300
        scale_out_cooldown = 60
        target_value       = 90
      }
    }
  }
}

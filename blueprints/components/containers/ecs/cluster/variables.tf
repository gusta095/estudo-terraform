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

# ------------------------------------------------------------------------------
# ECS Cluster
# ------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Nome do cluster ECS"
  type        = string

  validation {
    condition     = length(var.cluster_name) > 0 && length(var.cluster_name) <= 255
    error_message = "O nome do cluster ECS deve ter entre 1 e 255 caracteres."
  }

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_-]*$", var.cluster_name))
    error_message = "O nome do cluster ECS deve começar com uma letra e conter apenas letras, números, hífens (-) e underlines (_)."
  }
}

variable "fargate_capacity_providers" {
  description = "Mapa de definições dos provedores de capacidade Fargate para uso no cluster"
  type = map(object({
    default_capacity_provider_strategy = object({
      weight = number
      base   = optional(number)
    })
  }))
  default = {}
}

variable "default_capacity_provider_use_fargate" {
  description = "Define se o Fargate será o provedor de capacidade padrão. Precisa ser desativado para usar desired_count"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Número de dias para retenção dos eventos de log."
  type        = number
  default     = 90
}

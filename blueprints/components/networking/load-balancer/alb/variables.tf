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

variable "vpc_name" {
  description = "Nome da VPC da conta"
  type        = string
}

# ------------------------------------------------------------------------------
# ALB
# ------------------------------------------------------------------------------

variable "alb_name" {
  description = "Nome do Load Balancer"
  type        = string
  default     = null

  validation {
    condition     = length(var.alb_name) <= 32 && length(var.alb_name) > 0 && can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.alb_name))
    error_message = "O nome do ALB deve ter entre 1 e 32 caracteres, conter apenas letras, números ou hífens, e não pode começar ou terminar com um hífen."
  }
}

variable "load_balancer_type" {
  description = "Define o tipo de Load Balancer"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application"], var.load_balancer_type)
    error_message = "O tipo do Load Balancer deve ser application"
  }
}

variable "internal" {
  description = "Se verdadeiro, o Load Balancer será interno. O padrão é false"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Lista de IDs de subnets a serem associadas ao Load Balancer"
  type        = list(string)
  default     = null
}

variable "security_groups" {
  description = "Lista de IDs de Security Groups já existentes a serem atribuídos ao Load Balancer"
  type        = list(string)
  default     = []
}

variable "security_group_ingress_rules" {
  description = "Regras de entrada do Security Group a serem adicionadas ao grupo de segurança criado."
  type = map(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = optional(string)
    cidr_ipv4   = optional(string, "0.0.0.0/0")
  }))
  default = {}
}

variable "security_group_egress_rules" {
  description = "Regras de saída do Security Group a serem adicionadas ao grupo de segurança criado."
  type = map(object({
    from_port   = optional(number)
    to_port     = optional(number)
    ip_protocol = string
    description = optional(string)
    cidr_ipv4   = string
  }))
  default = {}
}

variable "listeners" {
  description = "Mapa de configurações de listeners a serem criados no Load Balancer."
  type = map(object({
    port            = number
    protocol        = string
    certificate_arn = optional(string) # Apenas necessário para HTTPS
    forward = optional(object({
      target_group_key = string
    }))
    redirect = optional(object({
      port        = string
      protocol    = string
      status_code = string
    }))
  }))
  default = {}
}

variable "target_groups" {
  description = "Mapa de configurações dos Target Groups a serem criados."
  type = map(object({
    backend_protocol     = optional(string) # possivelmente está errado e vai ser removido
    backend_port         = optional(number) # possivelmente está errado e vai ser removido
    protocol             = optional(string)
    port                 = optional(number)
    name_prefix          = optional(string)
    target_type          = string
    target_id            = optional(string)
    deregistration_delay = optional(number)

    load_balancing_cross_zone_enabled = optional(bool, false)

    health_check = optional(object({
      path                = string
      interval            = optional(number, 30)
      timeout             = optional(number, 5)
      healthy_threshold   = optional(number, 3)
      unhealthy_threshold = optional(number, 3)
    }))

    create_attachment = optional(bool, false)
  }))
  default = {}
}

variable "enable_deletion_protection" {
  description = "Define se a proteção contra exclusão do Load Balancer estará ativada"
  type        = bool
  default     = false
}

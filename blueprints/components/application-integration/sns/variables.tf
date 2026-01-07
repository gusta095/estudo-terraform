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

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}
# ------------------------------------------------------------------------------
# SNS
# ------------------------------------------------------------------------------

variable "name" {
  description = "O nome do tópico SNS a ser criado"
  type        = string
}

variable "default_policy_statements" {
  description = "Define se o policy statements padrão será aplicado"
  type        = bool
  default     = true
}

variable "topic_policy_statements" {
  description = "Lista de declarações de política IAM para permissões do SNS"
  type = list(object({
    sid           = optional(string)
    actions       = list(string)
    not_actions   = optional(list(string), [])
    effect        = string
    resources     = optional(list(string), [])
    not_resources = optional(list(string), [])
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), []) # Garantindo que nunca seja null
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), []) # Garantindo que nunca seja null
  }))
  default = []
}

variable "enable_default_topic_policy" {
  description = "Define se a política padrão do tópico SNS será ativada. O padrão é false"
  type        = bool
  default     = false
}

variable "subscriptions" {
  description = "Lista de assinaturas SNS"
  type = list(object({
    protocol              = string
    endpoint              = string
    raw_message_delivery  = optional(bool)
    subscription_role_arn = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for sub in var.subscriptions : contains(["sqs", "lambda", "firehose", "email", "sms"], sub.protocol)
    ])
    error_message = "Protocolo inválido. Valores suportados: sqs, lambda, firehose, email, sms."
  }
}

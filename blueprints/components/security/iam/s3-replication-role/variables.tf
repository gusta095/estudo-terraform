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
# S3 Replication Role
# ------------------------------------------------------------------------------

variable "name" {
  description = "O nome da policy e da role"
  type        = string
}

variable "origin_bucket_arn" {
  description = "ARN do bucket de origem, que vai enviar os arquivos"
  type        = string
  default     = null
}

variable "destination_bucket_arn" {
  description = "ARN do bucket de destino, que vai receber os arquivos"
  type        = string
  default     = null
}

variable "create_role" {
  description = "Define se uma role deve ser criada"
  type        = bool
  default     = true
}

variable "role_requires_mfa" {
  description = "Define se a role exige autenticação multifator (MFA)"
  type        = bool
  default     = false
}

variable "trusted_role_services" {
  description = "Serviços da AWS que podem assumir essas roles"
  type        = list(string)
  default     = []
}

variable "default_policy_replication_statements" {
  description = "Define se o policy de replicação padrão será aplicado"
  type        = bool
  default     = true
}

variable "s3_policy_replication_statements" {
  description = "Lista de declarações de política IAM para permissões personalizadas"
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

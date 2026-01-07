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
# Secret Manager
# ------------------------------------------------------------------------------

variable "name" {
  description = "Nome amigável do novo segredo"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9/_+=.@-]+$", var.name))
    error_message = "O nome do segredo só pode conter letras (maiúsculas e minúsculas), números e os seguintes caracteres: / _ + = . @ -"
  }
}

variable "description" {
  description = "Descrição do segredo"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Número de dias que o AWS Secrets Manager aguardará antes de excluir o segredo"
  type        = number
  default     = 0
}

variable "secret_string" {
  description = "Especifica os dados em texto que você deseja criptografar e armazenar nesta versão do segredo. Este campo é obrigatório se `secret_binary` não for definido."
  type        = string
}

# variable "create_policy" {
#   description = "Determina se uma política será criada"
#   type        = bool
#   default     = false
# }

# variable "secrets_manager_policy_statements" {
#   description = "Lista de declarações de política IAM para permissões personalizadas"
#   type = list(object({
#     sid           = optional(string)
#     actions       = list(string)
#     not_actions   = optional(list(string), [])
#     effect        = string
#     resources     = optional(list(string), [])
#     not_resources = optional(list(string), [])
#     principals = optional(list(object({
#       type        = string
#       identifiers = list(string)
#     })), [])
#     not_principals = optional(list(object({
#       type        = string
#       identifiers = list(string)
#     })), []) # Garantindo que nunca seja null
#     conditions = optional(list(object({
#       test     = string
#       variable = string
#       values   = list(string)
#     })), []) # Garantindo que nunca seja null
#   }))
#   default = []
# }

# variable "block_public_policy" {
#   description = "Faz uma chamada de API opcional para o Zelkova a fim de validar a política de recurso e evitar acesso amplo ao seu segredo"
#   type        = bool
#   default     = false
# }

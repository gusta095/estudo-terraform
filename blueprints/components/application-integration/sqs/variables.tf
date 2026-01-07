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
# SQS
# ------------------------------------------------------------------------------

variable "name" {
  description = "Nome legível para a fila. Se omitido, o Terraform atribuirá um nome aleatório"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "Tempo de visibilidade da fila"
  type        = number
  default     = 30

  validation {
    condition     = var.visibility_timeout_seconds >= 0 && var.visibility_timeout_seconds <= 43200
    error_message = "O valor de visibility_timeout_seconds deve estar entre 0 e 43200 segundos"
  }
}

variable "message_retention_seconds" {
  description = "O tempo, em segundos, que o SQS mantém uma mensagem"
  type        = number
  default     = 345600

  validation {
    condition     = var.message_retention_seconds >= 60 && var.message_retention_seconds <= 1209600
    error_message = "O valor de message_retention_seconds deve estar entre 60 e 1209600 segundos (14 dias)"
  }
}

variable "max_message_size" {
  description = "O tamanho máximo, em bytes, de uma mensagem antes de ser rejeitada"
  type        = number
  default     = 262144

  validation {
    condition     = var.max_message_size >= 1024 && var.max_message_size <= 262144
    error_message = "O valor de max_message_size deve estar entre 1024 e 262144 bytes."
  }
}

variable "delay_seconds" {
  description = "O tempo, em segundos, que todas as mensagens na fila terão de atraso antes da entrega"
  type        = number
  default     = 0

  validation {
    condition     = var.delay_seconds >= 0 && var.delay_seconds <= 900
    error_message = "O valor de delay_seconds deve estar entre 0 e 900 segundos (15 minutos)"
  }
}

variable "receive_wait_time_seconds" {
  description = "O tempo que uma chamada ReceiveMessage aguardará por uma mensagem antes de retornar"
  type        = number
  default     = 0

  validation {
    condition     = var.receive_wait_time_seconds >= 0 && var.receive_wait_time_seconds <= 20
    error_message = "O valor de receive_wait_time_seconds deve estar entre 0 e 20 segundos"
  }
}

variable "sqs_managed_sse_enabled" {
  description = "Habilita ou não a criptografia (SSE) do conteúdo das mensagens com chaves gerenciadas pelo SQS"
  type        = bool
  default     = true
}

variable "create_queue_policy" {
  description = "Define se a política da fila SQS será criada"
  type        = bool
  default     = true
}

variable "default_policy_statements" {
  description = "Define se o policy statements padrão será aplicado"
  type        = bool
  default     = true
}

variable "queue_policy_statements" {
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

variable "fifo_queue" {
  description = "Define se a fila será FIFO (First In, First Out)"
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# SQS DLQ (Dead Letter Queue)
# ------------------------------------------------------------------------------

variable "create_dlq" {
  description = "Define se a Dead Letter Queue (DLQ) será criada"
  type        = bool
  default     = false
}

variable "dlq_visibility_timeout_seconds" {
  description = "O tempo de visibilidade da DLQ"
  type        = number
  default     = 30

  validation {
    condition     = var.dlq_visibility_timeout_seconds >= 0 && var.dlq_visibility_timeout_seconds <= 43200
    error_message = "O valor de dlq_visibility_timeout_seconds deve estar entre 0 e 43200 segundos (12 horas)"
  }
}

variable "dlq_message_retention_seconds" {
  description = "O tempo, em segundos, que a Amazon SQS mantém uma mensagem na DLQ"
  type        = number
  default     = 345600

  validation {
    condition     = var.dlq_message_retention_seconds >= 60 && var.dlq_message_retention_seconds <= 1209600
    error_message = "O valor de dlq_message_retention_seconds deve estar entre 60 e 1209600 segundos (14 dias)"
  }
}

variable "dlq_delay_seconds" {
  description = "O tempo, em segundos, que todas as mensagens na DLQ terão de atraso antes da entrega"
  type        = number
  default     = 0

  validation {
    condition     = var.dlq_delay_seconds >= 0 && var.dlq_delay_seconds <= 900
    error_message = "O valor de dlq_delay_seconds deve estar entre 0 e 900 segundos (15 minutos)"
  }
}

variable "dlq_receive_wait_time_seconds" {
  description = "O tempo que uma chamada ReceiveMessage aguardará por uma mensagem na DLQ antes de retornar"
  type        = number
  default     = 0

  validation {
    condition     = var.dlq_receive_wait_time_seconds >= 0 && var.dlq_receive_wait_time_seconds <= 20
    error_message = "O valor de dlq_receive_wait_time_seconds deve estar entre 0 e 20 segundos"
  }
}

variable "dlq_sqs_managed_sse_enabled" {
  description = "Habilita ou não a criptografia (SSE) do conteúdo das mensagens da DLQ com chaves gerenciadas pelo SQS"
  type        = bool
  default     = true
}

variable "create_dlq_queue_policy" {
  description = "Define se a política da DLQ será criada"
  type        = bool
  default     = true
}

variable "dlq_queue_policy_statements" {
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

variable "dlq_default_policy_statements" {
  description = "Define se o policy statements padrão será aplicado"
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# AMBIENTE
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "tags" {
  description = "Key-value mapping of resource tags"
  type        = map(string)
}

# ------------------------------------------------------------------------------
# SQS
# ------------------------------------------------------------------------------

variable "name" {
  description = "Nome legível para a fila. Se omitido, o Terraform atribuirá um nome aleatório"
  type        = string
}

variable "create_queue_policy" {
  description = "Define se a política da fila SQS será criada"
  type        = bool
  default     = true
}

variable "queue_policy_statements" {
  description = "Mapa de declarações de política IAM para permissões personalizadas"
  type        = any
  default     = {}
}

# ------------------------------------------------------------------------------
# SNS
# ------------------------------------------------------------------------------

variable "create_topic_policy" {
  description = "Determina se uma política de tópico do SNS será criada"
  type        = bool
  default     = true
}

variable "topic_policy_statements" {
  description = "Um mapa de declarações de política IAM [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) para uso de permissões personalizadas"
  type        = any
  default     = {}
}

variable "raw_message_delivery" {
  description = "value"
  type        = bool
  default     = false
}

variable "additional_subscriptions" {
  description = "Assinaturas adicionais para o SNS"
  type = map(object({
    protocol             = string
    endpoint             = string
    raw_message_delivery = optional(bool, false)
  }))
  default = {}

  validation {
    condition     = alltrue([for s in values(var.additional_subscriptions) : contains(["sqs", "lambda", "application", "email"], s.protocol)])
    error_message = "O protocolo deve ser um dos seguintes: 'sqs', 'lambda', 'application' ou 'email'."
  }
}

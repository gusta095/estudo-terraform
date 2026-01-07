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
# LAMBDA
# ------------------------------------------------------------------------------

variable "function_name" {
  description = "Um nome único para sua Função Lambda"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,64}$", var.function_name))
    error_message = "O nome da Lambda deve conter até 64 caracteres alfanuméricos, hífens ou underscores."
  }
}

variable "description" {
  description = "Descrição da sua Função Lambda (ou Camada)"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Ponto de entrada da Função Lambda no seu código"
  type        = string
  default     = "index.lambda_handler"
}

variable "runtime" {
  description = "Runtime da Função Lambda"
  type        = string
  default     = ""
}

variable "source_path" {
  description = "O caminho absoluto para um arquivo ou diretório local contendo o código-fonte da sua Lambda"
  type        = any # string | list(string | map(any))
  default     = null
}

variable "architectures" {
  description = "Arquitetura do conjunto de instruções para sua Função Lambda. Valores válidos: [\"x86_64\"] e [\"arm64\"]."
  type        = list(string)
  default     = ["arm64"]

  validation {
    condition     = alltrue([for arch in var.architectures : contains(["x86_64", "arm64"], arch)])
    error_message = "A arquitetura da Lambda deve ser 'x86_64' ou 'arm64'."
  }
}

variable "event_source_mapping" {
  description = "Configuração do mapeamento entre a Lambda e a fonte de eventos, como SQS, Kinesis ou DynamoDB Streams."
  type = list(object({
    function_name                      = optional(string)
    event_source_arn                   = string
    enabled                            = optional(bool, true) # Ativa ou desativa o trigger
    batch_size                         = optional(number, 1)  # Número máximo de registros/eventos que a Lambda processa por invocação
    maximum_batching_window_in_seconds = optional(number, 0)  # Tempo máximo que a Lambda pode aguardar antes de processar um lote de eventos
  }))
  default = []
}

variable "allowed_triggers" {
  description = "Mapa de gatilhos permitidos para criar permissões da Lambda"
  type = map(object({
    principal  = string # O serviço que invoca a Lambda (ex: sns.amazonaws.com)
    source_arn = string # O ARN do recurso que acionará a Lambda (ex: ARN do SNS)
  }))
  default = {}
}

# ------------------------------------------------------------------------------
# POLICY
# ------------------------------------------------------------------------------

variable "attach_cloudwatch_logs_policy" {
  description = "Controla se a política do CloudWatch Logs deve ser adicionada à função IAM da Função Lambda."
  type        = bool
  default     = false
}

variable "attach_create_log_group_permission" {
  description = "Controla se a permissão para criar grupos de logs deve ser adicionada à política do CloudWatch Logs."
  type        = bool
  default     = false
}

variable "assume_role_policy_statements" {
  description = "Lista de declarações de política para definir quais entidades podem assumir a Role da Lambda (relação de confiança)."
  type = list(object({
    effect  = string
    actions = list(string)
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
  }))
  default = []
}

variable "attach_policy_statements" {
  description = "Define se as declarações de políticas (policy_statements) devem ser adicionadas ao papel (role) IAM da Função Lambda"
  type        = bool
  default     = true
}

variable "lambda_policy_statements" {
  description = "Lista de declarações de políticas IAM para definir permissões da Lambda."
  type = list(object({
    sid           = optional(string)
    actions       = list(string)
    not_actions   = optional(list(string), [])
    effect        = string
    resources     = list(string)
    not_resources = optional(list(string), [])
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
  }))
  default = []
}

variable "default_policy_statements" {
  description = "Define se o policy statements padrão será aplicado"
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# CLOUDWATCH LOGS
# ------------------------------------------------------------------------------

variable "logging_log_format" {
  description = "O formato de log da Função Lambda"
  type        = string
  default     = "Text"

  validation {
    condition     = contains(["JSON", "Text"], var.logging_log_format)
    error_message = "O formato de log deve ser JSON (estruturado) ou Text (texto simples)."
  }
}

variable "logging_application_log_level" {
  description = "O nível de log da aplicação na Função Lambda"
  type        = string
  default     = "INFO"

  validation {
    condition     = contains(["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL"], var.logging_application_log_level)
    error_message = "O nível de log deve ser um dos seguintes valores: TRACE, DEBUG, INFO, WARN, ERROR ou FATAL"
  }
}

variable "logging_system_log_level" {
  description = "O nível de log do sistema na Função Lambda"
  type        = string
  default     = "INFO"

  validation {
    condition     = contains(["DEBUG", "INFO", "WARN"], var.logging_system_log_level)
    error_message = "O nível de log do sistema deve ser um dos seguintes valores: DEBUG, INFO ou WARN"
  }
}

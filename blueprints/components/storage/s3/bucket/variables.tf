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

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

# ------------------------------------------------------------------------------
# BUCKET
# ------------------------------------------------------------------------------

variable "bucket_name" {
  description = "Nome do bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "O nome do bucket deve ter entre 3 e 63 caracteres."
  }

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name))
    error_message = "O nome do bucket deve conter apenas letras minúsculas, números, pontos e hífens, começando e terminando com um caractere alfanumérico."
  }

  validation {
    condition     = !can(regex("\\.\\.", var.bucket_name))
    error_message = "O nome do bucket não pode conter dois pontos consecutivos ('..')."
  }

  validation {
    condition     = !can(regex("^-|-$", var.bucket_name))
    error_message = "O nome do bucket não pode começar ou terminar com um hífen."
  }
}

variable "versioning" {
  description = "Configuração de versionamento do S3"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = true
}

variable "default_policy_statements" {
  description = "Define se o policy statements padrão será aplicado"
  type        = bool
  default     = true
}

variable "s3_policy_statements" {
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

# Não usa ACLs, seguindo a recomendação da AWS,pois ACLs são consideradas
# obsoletas para controle de acesso em buckets S3 modernos.
# https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/about-object-ownership.html

variable "acl" {
  description = "A ACL pré-definida a ser aplicada. Conflita com `grant`"
  type        = string
  default     = null
}

# Valores válidos:
#   - **BucketOwnerEnforced** (padrão): Desativa ACLs, garantindo que o dono do bucket tenha automaticamente total controle sobre todos os objetos.
#   - **BucketOwnerPreferred**: Se os objetos forem enviados com a ACL `bucket-owner-full-control`, a propriedade é transferida para o dono do bucket.
#   - **ObjectWriter**: A conta que faz o upload mantém a propriedade dos objetos, mesmo que sejam enviados com a ACL `bucket-owner-full-control`.

variable "object_ownership" {
  description = "Define o comportamento de propriedade dos objetos no bucket"
  type        = string
  default     = "BucketOwnerEnforced"

  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Valor inválido para 'object_ownership'. Use um dos seguintes: BucketOwnerEnforced, BucketOwnerPreferred ou ObjectWriter."
  }
}

variable "control_object_ownership" {
  description = "Define se o controle de propriedade de objetos do bucket S3 será gerenciado pelo Terraform."
  type        = bool
  default     = false
}

variable "access_public_bucket" {
  description = "libera todo o acesso público ao S3, definindo todas as opções de bloqueio como false."
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Define se o Amazon S3 deve bloquear ACLs públicas para este bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Define se o Amazon S3 deve bloquear políticas de bucket públicas para este bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Define se o Amazon S3 deve ignorar ACLs públicas para este bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Define se o Amazon S3 deve restringir políticas de bucket públicas para este bucket."
  type        = bool
  default     = true
}

variable "website" {
  description = "Mapa contendo a configuração de hospedagem ou redirecionamento de um site estático."
  type        = any # map(string)
  default     = {}
}

variable "lambda_notifications" {
  description = "Mapa de notificações do bucket S3 para funções Lambda"
  type = map(object({
    function_arn  = optional(string)
    function_name = optional(string)
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.lambda_notifications :
      alltrue([
        for event in v.events : contains(local.valid_s3_events, event)
      ])
    ])
    error_message = "Os eventos informados devem ser válidos para notificações do S3."
  }
}

variable "sqs_notifications" {
  description = "Mapa de notificações do bucket S3 para filas SQS"
  type = map(object({
    queue_name    = string # Nome da fila SQS (sem ARN)
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.sqs_notifications :
      alltrue([
        for event in v.events : contains(local.valid_s3_events, event)
      ])
    ])
    error_message = "Os eventos informados devem ser válidos para notificações do S3."
  }
}

variable "sns_notifications" {
  description = "Mapa de notificações do bucket S3 para tópicos SNS"
  type = map(object({
    topic_name    = string # Nome do topico SNS (sem ARN)
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.sns_notifications :
      alltrue([
        for event in v.events : contains(local.valid_s3_events, event)
      ])
    ])
    error_message = "Os eventos informados devem ser válidos para notificações do S3."
  }
}

variable "replication_configuration" {
  description = "Mapa contendo a configuração de replicação entre regiões."
  type        = any
  default     = {}
}

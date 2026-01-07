# SQS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sqs"></a> [sqs](#module\_sqs) | terraform-aws-modules/sqs/aws | 4.2.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Nome legível para a fila. Se omitido, o Terraform atribuirá um nome aleatório | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_create_dlq"></a> [create\_dlq](#input\_create\_dlq) | Define se a Dead Letter Queue (DLQ) será criada | `bool` | `false` | no |
| <a name="input_create_dlq_queue_policy"></a> [create\_dlq\_queue\_policy](#input\_create\_dlq\_queue\_policy) | Define se a política da DLQ será criada | `bool` | `true` | no |
| <a name="input_create_queue_policy"></a> [create\_queue\_policy](#input\_create\_queue\_policy) | Define se a política da fila SQS será criada | `bool` | `true` | no |
| <a name="input_default_policy_statements"></a> [default\_policy\_statements](#input\_default\_policy\_statements) | Define se o policy statements padrão será aplicado | `bool` | `true` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | O tempo, em segundos, que todas as mensagens na fila terão de atraso antes da entrega | `number` | `0` | no |
| <a name="input_dlq_default_policy_statements"></a> [dlq\_default\_policy\_statements](#input\_dlq\_default\_policy\_statements) | Define se o policy statements padrão será aplicado | `bool` | `true` | no |
| <a name="input_dlq_delay_seconds"></a> [dlq\_delay\_seconds](#input\_dlq\_delay\_seconds) | O tempo, em segundos, que todas as mensagens na DLQ terão de atraso antes da entrega | `number` | `0` | no |
| <a name="input_dlq_message_retention_seconds"></a> [dlq\_message\_retention\_seconds](#input\_dlq\_message\_retention\_seconds) | O tempo, em segundos, que a Amazon SQS mantém uma mensagem na DLQ | `number` | `345600` | no |
| <a name="input_dlq_queue_policy_statements"></a> [dlq\_queue\_policy\_statements](#input\_dlq\_queue\_policy\_statements) | Lista de declarações de política IAM para permissões personalizadas | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = optional(list(string), [])<br/>    not_resources = optional(list(string), [])<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>  }))</pre> | `[]` | no |
| <a name="input_dlq_receive_wait_time_seconds"></a> [dlq\_receive\_wait\_time\_seconds](#input\_dlq\_receive\_wait\_time\_seconds) | O tempo que uma chamada ReceiveMessage aguardará por uma mensagem na DLQ antes de retornar | `number` | `0` | no |
| <a name="input_dlq_sqs_managed_sse_enabled"></a> [dlq\_sqs\_managed\_sse\_enabled](#input\_dlq\_sqs\_managed\_sse\_enabled) | Habilita ou não a criptografia (SSE) do conteúdo das mensagens da DLQ com chaves gerenciadas pelo SQS | `bool` | `true` | no |
| <a name="input_dlq_visibility_timeout_seconds"></a> [dlq\_visibility\_timeout\_seconds](#input\_dlq\_visibility\_timeout\_seconds) | O tempo de visibilidade da DLQ | `number` | `30` | no |
| <a name="input_fifo_queue"></a> [fifo\_queue](#input\_fifo\_queue) | Define se a fila será FIFO (First In, First Out) | `bool` | `false` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | O tamanho máximo, em bytes, de uma mensagem antes de ser rejeitada | `number` | `262144` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | O tempo, em segundos, que o SQS mantém uma mensagem | `number` | `345600` | no |
| <a name="input_queue_policy_statements"></a> [queue\_policy\_statements](#input\_queue\_policy\_statements) | Lista de declarações de política IAM para permissões personalizadas | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = optional(list(string), [])<br/>    not_resources = optional(list(string), [])<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>  }))</pre> | `[]` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | O tempo que uma chamada ReceiveMessage aguardará por uma mensagem antes de retornar | `number` | `0` | no |
| <a name="input_sqs_managed_sse_enabled"></a> [sqs\_managed\_sse\_enabled](#input\_sqs\_managed\_sse\_enabled) | Habilita ou não a criptografia (SSE) do conteúdo das mensagens com chaves gerenciadas pelo SQS | `bool` | `true` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | Tempo de visibilidade da fila | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_arn"></a> [dlq\_arn](#output\_dlq\_arn) | O ARN da fila DLQ (Dead Letter Queue) |
| <a name="output_dlq_name"></a> [dlq\_name](#output\_dlq\_name) | O nome da fila DLQ |
| <a name="output_dlq_url"></a> [dlq\_url](#output\_dlq\_url) | A URL da fila DLQ criada |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | O ARN da fila SQS |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | O nome da fila SQS |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | A URL da fila SQS criada |
<!-- END_TF_DOCS -->

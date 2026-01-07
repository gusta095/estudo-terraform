# AWS Lambda

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
| <a name="module_alias_no_refresh"></a> [alias\_no\_refresh](#module\_alias\_no\_refresh) | terraform-aws-modules/lambda/aws//modules/alias | 7.20.1 |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | terraform-aws-modules/lambda/aws | 7.20.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Um nome único para sua Função Lambda | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_allowed_triggers"></a> [allowed\_triggers](#input\_allowed\_triggers) | Mapa de gatilhos permitidos para criar permissões da Lambda | <pre>map(object({<br/>    principal  = string # O serviço que invoca a Lambda (ex: sns.amazonaws.com)<br/>    source_arn = string # O ARN do recurso que acionará a Lambda (ex: ARN do SNS)<br/>  }))</pre> | `{}` | no |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Arquitetura do conjunto de instruções para sua Função Lambda. Valores válidos: ["x86\_64"] e ["arm64"]. | `list(string)` | <pre>[<br/>  "arm64"<br/>]</pre> | no |
| <a name="input_assume_role_policy_statements"></a> [assume\_role\_policy\_statements](#input\_assume\_role\_policy\_statements) | Lista de declarações de política para definir quais entidades podem assumir a Role da Lambda (relação de confiança). | <pre>list(object({<br/>    effect  = string<br/>    actions = list(string)<br/>    principals = list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    }))<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_attach_cloudwatch_logs_policy"></a> [attach\_cloudwatch\_logs\_policy](#input\_attach\_cloudwatch\_logs\_policy) | Controla se a política do CloudWatch Logs deve ser adicionada à função IAM da Função Lambda. | `bool` | `false` | no |
| <a name="input_attach_create_log_group_permission"></a> [attach\_create\_log\_group\_permission](#input\_attach\_create\_log\_group\_permission) | Controla se a permissão para criar grupos de logs deve ser adicionada à política do CloudWatch Logs. | `bool` | `false` | no |
| <a name="input_attach_policy_statements"></a> [attach\_policy\_statements](#input\_attach\_policy\_statements) | Define se as declarações de políticas (policy\_statements) devem ser adicionadas ao papel (role) IAM da Função Lambda | `bool` | `true` | no |
| <a name="input_default_policy_statements"></a> [default\_policy\_statements](#input\_default\_policy\_statements) | Define se o policy statements padrão será aplicado | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Descrição da sua Função Lambda (ou Camada) | `string` | `""` | no |
| <a name="input_event_source_mapping"></a> [event\_source\_mapping](#input\_event\_source\_mapping) | Configuração do mapeamento entre a Lambda e a fonte de eventos, como SQS, Kinesis ou DynamoDB Streams. | <pre>list(object({<br/>    function_name                      = optional(string)<br/>    event_source_arn                   = string<br/>    enabled                            = optional(bool, true) # Ativa ou desativa o trigger<br/>    batch_size                         = optional(number, 1)  # Número máximo de registros/eventos que a Lambda processa por invocação<br/>    maximum_batching_window_in_seconds = optional(number, 0)  # Tempo máximo que a Lambda pode aguardar antes de processar um lote de eventos<br/>  }))</pre> | `[]` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Ponto de entrada da Função Lambda no seu código | `string` | `"index.lambda_handler"` | no |
| <a name="input_lambda_policy_statements"></a> [lambda\_policy\_statements](#input\_lambda\_policy\_statements) | Lista de declarações de políticas IAM para definir permissões da Lambda. | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = list(string)<br/>    not_resources = optional(list(string), [])<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_logging_application_log_level"></a> [logging\_application\_log\_level](#input\_logging\_application\_log\_level) | O nível de log da aplicação na Função Lambda | `string` | `"INFO"` | no |
| <a name="input_logging_log_format"></a> [logging\_log\_format](#input\_logging\_log\_format) | O formato de log da Função Lambda | `string` | `"Text"` | no |
| <a name="input_logging_system_log_level"></a> [logging\_system\_log\_level](#input\_logging\_system\_log\_level) | O nível de log do sistema na Função Lambda | `string` | `"INFO"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime da Função Lambda | `string` | `""` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | O caminho absoluto para um arquivo ou diretório local contendo o código-fonte da sua Lambda | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda\_cloudwatch\_log\_group\_arn](#output\_lambda\_cloudwatch\_log\_group\_arn) | ARN do Cloudwatch Log Group |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | O ARN da Função Lambda |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | O nome da Função Lambda |
| <a name="output_lambda_function_url"></a> [lambda\_function\_url](#output\_lambda\_function\_url) | A URL da Função Lambda |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Última versão publicada da Função Lambda |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | O ARN da role IAM criada para a Função Lambda |
<!-- END_TF_DOCS -->

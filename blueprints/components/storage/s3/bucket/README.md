# S3 Bucket

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.6.0 |
| <a name="module_lambda_notifications"></a> [lambda\_notifications](#module\_lambda\_notifications) | terraform-aws-modules/s3-bucket/aws//modules/notification | 4.6.0 |
| <a name="module_sns_notifications"></a> [sns\_notifications](#module\_sns\_notifications) | terraform-aws-modules/s3-bucket/aws//modules/notification | 4.6.0 |
| <a name="module_sqs_notifications"></a> [sqs\_notifications](#module\_sqs\_notifications) | terraform-aws-modules/s3-bucket/aws//modules/notification | 4.6.0 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lambda_function.lambda_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_function) | data source |
| [aws_sns_topic.sns_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |
| [aws_sqs_queue.sqs_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Nome do bucket | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_access_public_bucket"></a> [access\_public\_bucket](#input\_access\_public\_bucket) | libera todo o acesso público ao S3, definindo todas as opções de bloqueio como false. | `bool` | `false` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | A ACL pré-definida a ser aplicada. Conflita com `grant` | `string` | `null` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `true` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Define se o Amazon S3 deve bloquear ACLs públicas para este bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Define se o Amazon S3 deve bloquear políticas de bucket públicas para este bucket. | `bool` | `true` | no |
| <a name="input_control_object_ownership"></a> [control\_object\_ownership](#input\_control\_object\_ownership) | Define se o controle de propriedade de objetos do bucket S3 será gerenciado pelo Terraform. | `bool` | `false` | no |
| <a name="input_default_policy_statements"></a> [default\_policy\_statements](#input\_default\_policy\_statements) | Define se o policy statements padrão será aplicado | `bool` | `true` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Define se o Amazon S3 deve ignorar ACLs públicas para este bucket. | `bool` | `true` | no |
| <a name="input_lambda_notifications"></a> [lambda\_notifications](#input\_lambda\_notifications) | Mapa de notificações do bucket S3 para funções Lambda | <pre>map(object({<br/>    function_arn  = optional(string)<br/>    function_name = optional(string)<br/>    events        = list(string)<br/>    filter_prefix = optional(string)<br/>    filter_suffix = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Define o comportamento de propriedade dos objetos no bucket | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | Mapa contendo a configuração de replicação entre regiões. | `any` | `{}` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Define se o Amazon S3 deve restringir políticas de bucket públicas para este bucket. | `bool` | `true` | no |
| <a name="input_s3_policy_statements"></a> [s3\_policy\_statements](#input\_s3\_policy\_statements) | Lista de declarações de política IAM para permissões personalizadas | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = optional(list(string), [])<br/>    not_resources = optional(list(string), [])<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>  }))</pre> | `[]` | no |
| <a name="input_sns_notifications"></a> [sns\_notifications](#input\_sns\_notifications) | Mapa de notificações do bucket S3 para tópicos SNS | <pre>map(object({<br/>    topic_name    = string # Nome do topico SNS (sem ARN)<br/>    events        = list(string)<br/>    filter_prefix = optional(string)<br/>    filter_suffix = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_sqs_notifications"></a> [sqs\_notifications](#input\_sqs\_notifications) | Mapa de notificações do bucket S3 para filas SQS | <pre>map(object({<br/>    queue_name    = string # Nome da fila SQS (sem ARN)<br/>    events        = list(string)<br/>    filter_prefix = optional(string)<br/>    filter_suffix = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Configuração de versionamento do S3 | <pre>object({<br/>    enabled = bool<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_website"></a> [website](#input\_website) | Mapa contendo a configuração de hospedagem ou redirecionamento de um site estático. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the bucket |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | The AWS region this bucket resides in |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL |
| <a name="output_bucket_website_domain"></a> [bucket\_website\_domain](#output\_bucket\_website\_domain) | The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. |
| <a name="output_bucket_website_endpoint"></a> [bucket\_website\_endpoint](#output\_bucket\_website\_endpoint) | The website endpoint, if the bucket is configured with a website. If not, this will be an empty string |
| <a name="output_bucket_zone_id"></a> [bucket\_zone\_id](#output\_bucket\_zone\_id) | The Route 53 Hosted Zone ID for this bucket's region |
<!-- END_TF_DOCS -->

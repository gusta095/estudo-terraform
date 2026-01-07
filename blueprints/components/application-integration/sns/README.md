# SNS

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
| <a name="module_sns"></a> [sns](#module\_sns) | terraform-aws-modules/sns/aws | 6.1.2 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kinesis_firehose_delivery_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kinesis_firehose_delivery_stream) | data source |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_function) | data source |
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | O nome do tópico SNS a ser criado | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_default_policy_statements"></a> [default\_policy\_statements](#input\_default\_policy\_statements) | Define se o policy statements padrão será aplicado | `bool` | `true` | no |
| <a name="input_enable_default_topic_policy"></a> [enable\_default\_topic\_policy](#input\_enable\_default\_topic\_policy) | Define se a política padrão do tópico SNS será ativada. O padrão é false | `bool` | `false` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | Lista de assinaturas SNS | <pre>list(object({<br/>    protocol              = string<br/>    endpoint              = string<br/>    raw_message_delivery  = optional(bool)<br/>    subscription_role_arn = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_topic_policy_statements"></a> [topic\_policy\_statements](#input\_topic\_policy\_statements) | Lista de declarações de política IAM para permissões do SNS | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = optional(list(string), [])<br/>    not_resources = optional(list(string), [])<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_arns"></a> [subscription\_arns](#output\_subscription\_arns) | ARNs das subscrições SNS criadas |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | O ARN do tópico SNS, como uma propriedade mais óbvia (clone do id) |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | O ARN do tópico SNS |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | O nome do tópico |
| <a name="output_topic_owner"></a> [topic\_owner](#output\_topic\_owner) | O ID da conta AWS do proprietário do tópico SNS |
<!-- END_TF_DOCS -->

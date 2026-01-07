# Event driven message

Está é uma infra pré montada que permite criar um SNS com subscribition já configurada em um SQS

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
| <a name="module_sns"></a> [sns](#module\_sns) | ../../application-integration/sns | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ../../application-integration/sqs | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Nome legível para a fila. Se omitido, o Terraform atribuirá um nome aleatório | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value mapping of resource tags | `map(string)` | n/a | yes |
| <a name="input_additional_subscriptions"></a> [additional\_subscriptions](#input\_additional\_subscriptions) | Assinaturas adicionais para o SNS | <pre>map(object({<br/>    protocol             = string<br/>    endpoint             = string<br/>    raw_message_delivery = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_create_queue_policy"></a> [create\_queue\_policy](#input\_create\_queue\_policy) | Define se a política da fila SQS será criada | `bool` | `true` | no |
| <a name="input_create_topic_policy"></a> [create\_topic\_policy](#input\_create\_topic\_policy) | Determina se uma política de tópico do SNS será criada | `bool` | `true` | no |
| <a name="input_queue_policy_statements"></a> [queue\_policy\_statements](#input\_queue\_policy\_statements) | Mapa de declarações de política IAM para permissões personalizadas | `any` | `{}` | no |
| <a name="input_raw_message_delivery"></a> [raw\_message\_delivery](#input\_raw\_message\_delivery) | value | `bool` | `false` | no |
| <a name="input_topic_policy_statements"></a> [topic\_policy\_statements](#input\_topic\_policy\_statements) | Um mapa de declarações de política IAM [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) para uso de permissões personalizadas | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | O ARN da fila SQS |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | O nome da fila SQS |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | A URL da fila SQS criada |
| <a name="output_sns_additional_subscriptions"></a> [sns\_additional\_subscriptions](#output\_sns\_additional\_subscriptions) | Lista de assinaturas adicionais do SNS, contendo apenas protocolo e endpoint |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | O ARN do tópico SNS, como uma propriedade mais explícita (clone do ID) |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | O ARN do tópico SNS |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | O nome do tópico SNS |
| <a name="output_topic_owner"></a> [topic\_owner](#output\_topic\_owner) | O ID da conta AWS do proprietário do tópico SNS |
<!-- END_TF_DOCS -->

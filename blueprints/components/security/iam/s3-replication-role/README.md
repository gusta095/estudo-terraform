# KMS

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
| <a name="module_iam_assumable_role"></a> [iam\_assumable\_role](#module\_iam\_assumable\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | 5.54.0 |
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.54.0 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | O nome da policy e da role | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Define se uma role deve ser criada | `bool` | `true` | no |
| <a name="input_default_policy_replication_statements"></a> [default\_policy\_replication\_statements](#input\_default\_policy\_replication\_statements) | Define se o policy de replicação padrão será aplicado | `bool` | `true` | no |
| <a name="input_destination_bucket_arn"></a> [destination\_bucket\_arn](#input\_destination\_bucket\_arn) | ARN do bucket de destino, que vai receber os arquivos | `string` | `null` | no |
| <a name="input_origin_bucket_arn"></a> [origin\_bucket\_arn](#input\_origin\_bucket\_arn) | ARN do bucket de origem, que vai enviar os arquivos | `string` | `null` | no |
| <a name="input_role_requires_mfa"></a> [role\_requires\_mfa](#input\_role\_requires\_mfa) | Define se a role exige autenticação multifator (MFA) | `bool` | `false` | no |
| <a name="input_s3_policy_replication_statements"></a> [s3\_policy\_replication\_statements](#input\_s3\_policy\_replication\_statements) | Lista de declarações de política IAM para permissões personalizadas | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = list(string)<br/>    not_actions   = optional(list(string), [])<br/>    effect        = string<br/>    resources     = optional(list(string), [])<br/>    not_resources = optional(list(string), [])<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), [])<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })), []) # Garantindo que nunca seja null<br/>  }))</pre> | `[]` | no |
| <a name="input_trusted_role_services"></a> [trusted\_role\_services](#input\_trusted\_role\_services) | Serviços da AWS que podem assumir essas roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | The name of the policy |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
<!-- END_TF_DOCS -->

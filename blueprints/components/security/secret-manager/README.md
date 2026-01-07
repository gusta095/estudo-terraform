# KMS

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
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | terraform-aws-modules/secrets-manager/aws | 1.3.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Nome amigável do novo segredo | `string` | n/a | yes |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | Especifica os dados em texto que você deseja criptografar e armazenar nesta versão do segredo. Este campo é obrigatório se `secret_binary` não for definido. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Descrição do segredo | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Número de dias que o AWS Secrets Manager aguardará antes de excluir o segredo | `number` | `0` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

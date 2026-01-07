# S3 Global Resources

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_account_public_access_block.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for buckets in this account. Enabling this setting does not affect existing policies or ACLs | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for buckets in this account. Enabling this setting does not affect existing bucket policies | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_block_public_acls"></a> [block\_public\_acls](#output\_block\_public\_acls) | The block public ACLs status |
| <a name="output_block_public_policy"></a> [block\_public\_policy](#output\_block\_public\_policy) | The block public policy status |
<!-- END_TF_DOCS -->

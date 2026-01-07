# NLB

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
| <a name="module_nlb"></a> [nlb](#module\_nlb) | terraform-aws-modules/alb/aws | 9.14.0 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_subnets.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc_infos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Nome da VPC da conta | `string` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Define se a proteção contra exclusão do Load Balancer estará ativada | `bool` | `false` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Se verdadeiro, o Load Balancer será interno. O padrão é false | `bool` | `false` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | Mapa de configurações de listeners a serem criados no Load Balancer. | <pre>map(object({<br/>    port            = number<br/>    protocol        = string<br/>    certificate_arn = optional(string) # Apenas necessário para HTTPS<br/>    forward = optional(object({<br/>      target_group_key = string<br/>    }))<br/>    redirect = optional(object({<br/>      port        = string<br/>      protocol    = string<br/>      status_code = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Define o tipo de Load Balancer | `string` | `"network"` | no |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | Nome do Load Balancer | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Regras de saída do Security Group a serem adicionadas ao grupo de segurança criado. | <pre>map(object({<br/>    from_port   = optional(number)<br/>    to_port     = optional(number)<br/>    ip_protocol = string<br/>    description = optional(string)<br/>    cidr_ipv4   = string<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Regras de entrada do Security Group a serem adicionadas ao grupo de segurança criado. | <pre>map(object({<br/>    from_port   = number<br/>    to_port     = number<br/>    ip_protocol = string<br/>    description = optional(string)<br/>    cidr_ipv4   = optional(string, "0.0.0.0/0")<br/>  }))</pre> | `{}` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Lista de IDs de Security Groups já existentes a serem atribuídos ao Load Balancer | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Lista de IDs de subnets a serem associadas ao Load Balancer. Para Load Balancers do tipo `network`, as subnets não podem ser atualizadas. Alterar este valor em Load Balancers `network` resultará na recriação do recurso. | `list(string)` | `null` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Mapa de configurações dos Target Groups a serem criados. | <pre>map(object({<br/>    backend_protocol     = optional(string) # possivelmente está errado e vai ser removido<br/>    backend_port         = optional(number) # possivelmente está errado e vai ser removido<br/>    protocol             = optional(string)<br/>    port                 = optional(number)<br/>    name_prefix          = optional(string)<br/>    target_type          = string<br/>    target_id            = optional(string)<br/>    deregistration_delay = optional(number)<br/><br/>    load_balancing_cross_zone_enabled = optional(bool, false)<br/><br/>    health_check = optional(object({<br/>      path                = string<br/>      interval            = optional(number, 30)<br/>      timeout             = optional(number, 5)<br/>      healthy_threshold   = optional(number, 3)<br/>      unhealthy_threshold = optional(number, 3)<br/>    }))<br/><br/>    create_attachment = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN do Load Balancer criado. |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | Nome DNS do Load Balancer, usado para acessá-lo diretamente. |
| <a name="output_listener_rules"></a> [listener\_rules](#output\_listener\_rules) | Mapa das regras de listeners criadas e seus atributos. |
| <a name="output_listeners"></a> [listeners](#output\_listeners) | Mapa dos listeners criados e seus atributos. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Lista de IDs de subnets publicas |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | ARN (Amazon Resource Name) do Security Group associado ao Load Balancer. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID do Security Group associado ao Load Balancer. |
| <a name="output_target_groups"></a> [target\_groups](#output\_target\_groups) | Mapa dos target groups criados e seus atributos. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
<!-- END_TF_DOCS -->

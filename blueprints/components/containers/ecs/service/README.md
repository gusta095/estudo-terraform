# ECS Cluster

## Conceito do Modo Worker

### **Modo `ecs_worker` = `true`**

Quando o modo worker está **ativado**, são criados apenas os recursos essenciais para a execução da aplicação, **sem a necessidade de
balanceamento de carga** (ALB/NLB). Esse modo é ideal para **aplicações que atuam como consumidores ou produtores de mensagens** (por
exemplo, usando SQS, SNS, Kafka), onde o tráfego é gerido diretamente pelos serviços de fila ou tópicos, sem a necessidade de um
balanceador de carga.

- **Aplicações típicas**: Processamento em segundo plano, filas de mensagens, serviços que não exigem balanceamento de carga.
- **Ponto importante**: A variável `ecs_worker` por padrão é `true`

### **Modo `ecs_worker` = `false`**

Quando o modo worker está **desativado**, são criados **recursos adicionais**, como ALB (Application Load Balancer), NLB (Network Load
Balancer) e listeners. Esses recursos são necessários para oferecer suporte a **aplicações mais complexas**, como **APIs REST**, que
exigem **balanceamento de carga** e **escalabilidade**. Nesse modo, as **tarefas ECS** ficam acessíveis através do balanceamento de carga,
permitindo distribuir o tráfego de rede de forma eficiente.

- **Aplicações típicas**: APIs web, microserviços com balanceamento de carga, aplicações que precisam de escalabilidade dinâmica.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | terraform-aws-modules/ecs/aws//modules/service | 5.12.0 |
| <a name="module_tags"></a> [tags](#module\_tags) | git::ssh://git@gitlab.com/gusta-lab/terraform/aws/modules/tags.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.http_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_lb.alb_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc_infos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Nome do cluster ECS | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | O nome do ambiente | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapeamento de chave-valor para tags dos recursos | `map(string)` | n/a | yes |
| <a name="input_vpc_primary_name"></a> [vpc\_primary\_name](#input\_vpc\_primary\_name) | Nome da VPC principal que será utilizada na região | `string` | n/a | yes |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Alb name | `string` | `null` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Define se um endereço IP público será atribuído à ENI (somente para o tipo de execução Fargate) | `bool` | `true` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | The maximum number of tasks that can run in the service. | `number` | `2` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | The minimum number of tasks that should be running in the service. | `number` | `1` | no |
| <a name="input_autoscaling_policies"></a> [autoscaling\_policies](#input\_autoscaling\_policies) | Defines the autoscaling policies for the service. | `any` | <pre>{<br/>  "cpu": {<br/>    "policy_type": "TargetTrackingScaling",<br/>    "target_tracking_scaling_policy_configuration": {<br/>      "predefined_metric_specification": {<br/>        "predefined_metric_type": "ECSServiceAverageCPUUtilization"<br/>      },<br/>      "scale_in_cooldown": 300,<br/>      "scale_out_cooldown": 60,<br/>      "target_value": 90<br/>    }<br/>  },<br/>  "memory": {<br/>    "policy_type": "TargetTrackingScaling",<br/>    "target_tracking_scaling_policy_configuration": {<br/>      "predefined_metric_specification": {<br/>        "predefined_metric_type": "ECSServiceAverageMemoryUtilization"<br/>      },<br/>      "scale_in_cooldown": 300,<br/>      "scale_out_cooldown": 60,<br/>      "target_value": 90<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | Um mapa de definições de contêiner usadas pelo Amazon ECS | <pre>map(object({<br/>    image     = string<br/>    cpu       = optional(number, 256)<br/>    memory    = optional(number, 512)<br/>    essential = optional(bool, true)<br/>    port_mappings = optional(list(object({<br/>      name          = optional(string)<br/>      containerPort = number<br/>      # hostPort      = optional(number, 0)<br/>      protocol = optional(string, "tcp")<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Determina se o recurso do serviço será criado | `bool` | `true` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Número de instâncias da definição de tarefa a serem criadas e mantidas em execução | `number` | `1` | no |
| <a name="input_ecs_worker"></a> [ecs\_worker](#input\_ecs\_worker) | flag para ativar e desativar o modo worker | `bool` | `true` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Enables or disables autoscaling for the service. | `bool` | `true` | no |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | Bloco de configuração para balanceadores de carga | `any` | `{}` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | Política de segurança SSL/TLS para o listener do Load Balancer | `string` | `"ELBSecurityPolicy-2016-08"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_container_definitions"></a> [service\_container\_definitions](#output\_service\_container\_definitions) | Container definitions |
| <a name="output_service_iam_role_arn"></a> [service\_iam\_role\_arn](#output\_service\_iam\_role\_arn) | ARN da função IAM do serviço |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | ARN que identifica o serviço |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | Nome do serviço |
| <a name="output_service_security_group_arn"></a> [service\_security\_group\_arn](#output\_service\_security\_group\_arn) | ARN do grupo de segurança |
| <a name="output_service_security_group_id"></a> [service\_security\_group\_id](#output\_service\_security\_group\_id) | ID do grupo de segurança |
| <a name="output_service_task_definition_arn"></a> [service\_task\_definition\_arn](#output\_service\_task\_definition\_arn) | ARN completo da definição de tarefa (inclui `family` e `revision`) |
| <a name="output_service_task_exec_iam_role_arn"></a> [service\_task\_exec\_iam\_role\_arn](#output\_service\_task\_exec\_iam\_role\_arn) | ARN da função IAM para execução de tarefas |
| <a name="output_service_task_set_arn"></a> [service\_task\_set\_arn](#output\_service\_task\_set\_arn) | ARN que identifica o conjunto de tarefas |
| <a name="output_service_tasks_iam_role_arn"></a> [service\_tasks\_iam\_role\_arn](#output\_service\_tasks\_iam\_role\_arn) | ARN da função IAM para as tarefas |
<!-- END_TF_DOCS -->

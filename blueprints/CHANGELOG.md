# Changelog

## Unreleased

## v25.04.2 - 2025-04-10

- Blueprint `components/security/secret-manager`
  - Versão inicial criada

## v25.04.1 - 2025-04-06

- Blueprint `components/security/iam/s3-replication-role`
  - Ajustar variaveis de origin e destination bucket
  - Adição de suporte a default tag policy

## v25.04.0 - 2025-04-01

- Blueprint `components/containers/ecs/service`
  - Add suporte as configs do autoscaling

## v25.03.22 - 2025-03-29

- Blueprint `components/security/iam/s3-replication-role`
  - Criação de blueprint para policy e role
  - Criação de assume role para s3 replication
- Blueprint `components/storage/s3/bucket`
  - Adição de suporte a s3 replication

## v25.03.21 - 2025-03-27

- Blueprint `components/containers/ecs/service`
  - Suporte a sidecar implementado
  - Ajuste automatico do tamanho da task definition

## v25.03.20 - 2025-03-26

- Blueprint `components/containers/ecs/service`
  - Removido o suporte a `service_connect_configuration`
  - Removido o suporte a criação de container via `container`
  - Adicionado suporte a criação de containers via `container_definitions`
  - Ajustes no output

## v25.03.19 - 2025-03-26

- Blueprint `components/containers/ecs/service`
  - Suporte a rodar sem um ALB ou NLB via flag

## v25.03.18 - 2025-03-23

- Blueprint `components/containers/ecs/service`
  - Separei o ECS Service do ALB
  - Ajustei os outputs
  - refatorei os datas

## v25.03.17 - 2025-03-22

- Blueprint `components/networking/load-balancer/alb`
  - Criação de blueprint para o alb
- Blueprint `components/networking/load-balancer/nlb`
  - Criação de blueprint para o nlb

## v25.03.16 - 2025-03-21

- Blueprint `components/containers/ecs/service`
  - refatoração da blueprint de ecs service
  - Criando o fluxo completo

## v25.03.15 - 2025-03-17

- Blueprint `components/containers/ecs/cluster`
  - refatoração da blueprint de ecs
  - criação da ecs cluster

## v25.03.14 - 2025-03-16

- Blueprint `components/storage/s3/bucket`
  - Simplificação do lambda subscription
  - Ajustes nas validações das subscriptions

## v25.03.13 - 2025-03-16

- Update do modulo de tags em todas as blueprints
  - Foi ajustado o problema do `created-time`

## v25.03.12 - 2025-03-16

- Blueprint `components/compute/lambda`
  - Adicionada validação em alguns outputs

## v25.03.11 - 2025-03-15

- Blueprint `components/storage/s3/bucket`
  - Adicionada validação em alguns outputs
- Blueprint `components/application-integration/sqs`
  - Adicionada validação nos inputs do SQS e DLQ
- Blueprint `components/application-integration/sns`
  - Adicionado o output para subscriptions
  - Adicionada validação em alguns outputs

## v25.03.10 - 2025-03-15

- Blueprint `components/compute/lambda`
  - Adicionado suporte à criação de aliases para versionamento de funções
  - Novo exemplo de integração com SNS Trigger para disparo de eventos

## v25.03.9 - 2025-03-12

- Blueprint `components/application-integration/sqs`
  - Adicionada flag `disable_default_policy` para controle de políticas padrão
- Blueprint `components/storage/s3/bucket`
  - Adicionada flag `disable_default_policy` para desativar políticas automáticas
- Blueprint `components/compute/lambda`
  - Nova flag `disable_default_policy` para personalização de permissões

## v25.03.8 - 2025-03-09

- Blueprint `components/application-integration/sqs`
  - Refatoração da lógica de políticas padrão para melhor modularização
- Blueprint `components/application-integration/sns`
  - Políticas padrão reestruturadas e flag `disable_default_policy` adicionada
- Blueprint `components/storage/s3/bucket`
  - Melhoria na estruturação das políticas padrão do bucket

## v25.03.7 - 2025-03-08

- Blueprint `components/compute/lambda`
  - Simplificação das políticas padrão para funções Lambda
  - Novo exemplo de configuração com trigger SQS

## v25.03.6 - 2025-03-05

- Blueprint `components/compute/lambda`
  - Suporte à criação automática de políticas padrão
  - Adição de tags específicas para rastreamento de políticas

## v25.03.5 - 2025-03-04

- Blueprint `components/compute/lambda`
  - Versão básica inicial do blueprint
  - Exemplo `simples` adicionado para implantação rápida
  - Controle aprimorado de roles assumidas e grupos de logs

## v25.03.4 - 2025-03-03

## v25.03.3 - 2025-03-03

- Blueprint `components/storage/s3/bucket`
  - Implementação de políticas padrão para buckets
  - Atualização do módulo de tags para compatibilidade com Terraform 1.11
  - Exemplos reformulados com interpolação dinâmica
  - Adição de flag `enable_public_access` para exposição pública
  - Suporte à hospedagem de sites estáticos
- Aprimoramento de documentação e exemplos em todos os blueprints

## v25.03.2 - 2025-03-02

- Blueprint `components/application-integration/sns`
  - Variável `topic_policy_statements` reformulada para maior flexibilidade
  - Políticas padrão para tópicos SNS implementadas
  - Tags indicativas para identificação de políticas padrão
  - Variável `subscriptions` convertida para lista de objetos
- Blueprint `components/security/kms`
  - Versão simplificada para criação de chaves KMS

## v25.03.1 - 2025-03-02

- Padronização do uso de `find_in_parent_folders("root.hcl")` em exemplos
- Atualização de versões:
  - Terragrunt para `0.73.16`
  - Terraform para `1.11.0`
  - Terraform-docs para `0.19.0`
  - Pre-commit hooks atualizados

## v25.03.0 - 2025-03-01

- Blueprint `components/application-integration/sqs`
  - Reversão para módulo de tags padrão do Terraform
  - Políticas padrão para filas SQS e DLQ (Dead Letter Queue)
  - Tags indicativas para uso de políticas padrão

## v25.02.12 - 2025-02-28

- Blueprint `components/application-integration/sqs`
  - Input `queue_policy_statements` ajustado para aceitar lista de políticas
- Blueprint `components/storage/s3/bucket`
  - Inputs `sqs_notifications` e `sns_notifications` agora aceitam nomes e ARNs

## v25.02.11 - 2025-02-25

- Blueprint `components/application-integration/sns`
  - Refatoração do input `topic_policy_statements` para suportar múltiplas assinaturas
  - Suporte a endpoints por nome ou ARN
  - Lógica ajustada: `enable_default_topic_policy` ativa apenas se `topic_policy_statements` estiver vazio
  - Atualização do módulo AWS SNS para versão `6.1.2`
- Blueprint `components/application-integration/sqs`
  - Removida necessidade de `create_queue_policy = true` para criação de políticas

## v25.02.10 - 2025-02-23

- Blueprint `components/storage/s3/bucket`
  - Novos exemplos adicionados:
    - `acl-private`: Configuração de ACL privada
    - `all-notification`: Notificações para SQS, SNS e Lambda
    - `object-ownership`: Controle de propriedade de objetos
    - `public-access`: Bucket com acesso público controlado
    - `with-policy`: Bucket com política personalizada

## v25.02.9 - 2025-02-22

- Correção de regras do Tflint em blueprints

## v25.02.8 - 2025-02-22

- Ajuste na geração de documentação via `terraform-docs`

## v25.02.7 - 2025-02-22

- Adição de documentação automatizada para:
  - Blueprint `components/application-integration/sns`
  - Use-case `components/use-case/event-driven-message`

## v25.02.6 - 2025-02-22

- Novo use-case `event-driven-message` para arquiteturas baseadas em eventos
- Refatoração do blueprint `components/application-integration/sns` para melhor escalabilidade

## v25.02.5 - 2025-02-21

- Criação do diretório `shared` para módulos reutilizáveis
- Tradução de descrições para português em `components/application-integration/sqs`
- Integração do blueprint SQS com módulos compartilhados

## v25.02.4 - 2025-02-21

- Atualização do `Makefile` para suportar novos comandos de automação

## v25.02.3 - 2025-02-21

## v25.02.2 - 2025-02-21

## v25.02.1 - 2025-02-21

- Testes iniciais de funcionalidades do `Makefile`

## v25.02.0 - 2025-02-20

- Blueprint `components/compute/instance`
  - Suporte a `data sources` para consulta de informações de infraestrutura

## v24.10.0 - 2024-10-05

## v24.04.0 - 2024-04-09

- Blueprint `components/containers/ecs`
  - Suporte a configuração HTTPS para serviços ECS

## v24.03.11 - 2024-03-28

- Blueprint `components/security/acm`
  - Criação automatizada de certificados ACM
- Blueprint `components/containers/eks`
  - Ajustes de configuração para clusters EKS

## v24.03.10 - 2024-03-27

- Blueprint `components/containers/eks`
  - Remoção de políticas redundantes no node group

## v24.03.9 - 2024-03-26

- Blueprint `components/networking/route53`
  - Criação de zonas DNS e registros
- Blueprint `components/containers/ecs`
  - Documentação detalhada de implantação
- Blueprint `components/containers/eck`
  - Atualização de parâmetros de configuração

## v24.03.8 - 2024-03-24

- Blueprint `components/containers/eks`
  - Configuração do Cluster Autoscaler para escalonamento automático

## v24.03.7 - 2024-03-22

- Blueprint `components/containers/eks`
  - Adição de Managed Node Groups para worker nodes
- Blueprint `components/containers/ecs`
  - Novos outputs para integração com outros serviços
- Blueprint `components/compute/instance`
  - Configuração de instâncias para Minikube

## v24.03.6 - 2024-03-21

- Blueprint `components/compute/user-data`
  - Scripts de user-data para inicialização de Minikube

## v24.03.5 - 2024-03-21

- Correção de remoção inadvertida de tags em volumes raiz (blueprints de compute)

## v24.03.4 - 2024-03-21

- Ajuste de tags para compliance com políticas de custos

## v24.03.3 - 2024-03-21

- Blueprint `components/compute`
  - Suporte a configuração de disco raiz personalizado
  - Atualização de versões de módulos Terraform

## v24.03.2 - 2024-03-21

- Blueprint `components/containers/ecs`
  - Primeira versão estável com suporte a serviços ECS
  - Exemplos de assinatura em `components/application-integration`

## v24.03.1 - 2024-03-10

- Blueprint `components/application-integration/sns`
  - Suporte a assinaturas SQS para tópicos SNS

## v24.03.0 - 2024-03-08

- Blueprint `components/application-integration/sns`
  - Implementação inicial de tópicos SNS
- Blueprint `components/application-integration/sqs`
  - Novos exemplos de configuração de filas

## v23.12.0 - 2023-12-06

- Apresentação interna da estrutura de blueprints para o time

## v23.11.9 - 2023-11-13

- Blueprint `components/compute/instance`
  - Nova variável `additional_ingress_with_cidr_blocks` para regras de segurança

## v23.11.8 - 2023-11-12

- Blueprint `components/compute/user-data`
  - Instalação automática do Docker via scripts de inicialização

## v23.11.7 - 2023-11-06

- Terceira iteração de testes de integração contínua com GitLab

## v23.11.6 - 2023-11-06

- Segunda fase de testes de CI/CD no GitLab

## v23.11.5 - 2023-11-06

- Integração inicial do pipeline com GitLab

## v23.11.4 - 2023-11-05

- Movimento de scripts para o diretório `_bin` para organização

## v23.11.3 - 2023-11-04

- Reformulação do pipeline de CI para estágios paralelos
- Adição de verificação de segredos com GitGuardian

## v23.11.2 - 2023-11-02

- Blueprint `components/application-integration/sns`
  - Versão inicial de tópicos SNS
- Blueprint `components/compute/instance`
  - Regra de segurança para acesso via IP do usuário

## v23.11.1 - 2023-11-01

- Breaking change: Reestruturação de diretórios para padronização

## v23.11.0 - 2023-11-01

- Blueprint `components/application-integration/sqs`
  - Implementação inicial de filas SQS
- Renomeação do exemplo `VPC Simple` para `Default` em `components/networking/vpc/examples`

## v23.10.8 - 2023-10-31

- Blueprint `components/compute/instance`
  - Suporte a scripts customizados via user-data

## v23.10.7 - 2023-10-29

- Blueprint `components/compute/instance`
  - Integração com outputs de VPC (subnets, security groups)
- Blueprint `components/networking/vpc`
  - Criação de VPCs com configuração básica

## v23.10.6 - 2023-10-28

- Blueprint `components/compute/instance`
  - Primeira versão para criação de instâncias EC2

## v23.10.5 - 2023-10-28

- Blueprint `components/storage/s3`
  - Implementação inicial de buckets S3

## v23.10.4 - 2023-10-27

- Blueprint `components/null`
  - Módulo placeholder para operações de depuração

## v23.10.3 - 2023-10-27

- Blueprint `components/organizations/account-alias`
  - Configuração inicial de alias para contas AWS

## v23.10.2 - 2023-10-27

- Finalização da configuração base do repositório

## v23.10.1 - 2023-10-27

- Inicialização do repositório com estrutura básica de blueprints

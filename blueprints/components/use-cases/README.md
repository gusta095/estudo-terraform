# Use Cases

Este diretório contém casos de uso específicos para a infraestrutura do **AWS Config Live**, demonstrando diferentes cenários de integração e arquitetura na AWS.

## Estrutura do Diretório

- **event-driven-message/**: Exemplo de arquitetura orientada a eventos usando SNS e SQS.
- **examples/**: Demosntra formas de utiliza o `event-driven-message`.
  - **simple/**: Configuração mínima para um caso de uso.
  - **multi-subscriptions/**: Configuração com múltiplas assinaturas de SNS.

### Requisitos

- **Terraform** >= 1.6.2
- **Terragrunt** >= 0.53.0
- AWS CLI configurado com credenciais adequadas

## Contato
Para dúvidas ou sugestões, entre em contato com o responsável pelo repositório.

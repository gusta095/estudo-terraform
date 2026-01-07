# Backlog

<!-- - ajustar o sqs_notifications e sns_notifications para receberem nomes e arns com input -->
<!-- - Entender o uso do data "aws_iam_policy_document" "s3_policy" no modulo de s3 -->
<!-- - Adicionar suporte a default policys no SQS -->
<!-- - revisando as config do SQS DLQ -->
<!-- - revisando as config do SQS-fifo e DLQ-fifo -->
<!-- - fazer melhorias no modulo de tags - deixalo mais automatico -->
<!-- - adicionar tags default policy -->
<!-- - fazer melhorias e updatas no aws-config-live -->
<!-- - update do terraform e terragrunt -->
<!-- - adicionar forma de ativar e desativar o modulo de tags - achei outra solução  -->
<!-- - implementar default policy no sns -->
<!-- - implementar default policy no s3 -->
<!-- - suporte de tags de default policy -->
<!-- - adicionar suporte a site estatico -->
<!-- - criar uma blueprint de lambda basica -->
<!-- - refatorar sistema de default policy tag -->
<!-- - implementar o default policy na lambda -->
<!-- - implementar assume role controler -->
<!-- - implementar controle de log group -->
<!-- - implementar todas as melhorias dos outros Serviços no lambda -->
<!-- - refatorar todo o sistema de default policy -->
  <!-- - refatorado o do lambda -->
  <!-- - refatorar do SQS -->
  <!-- - refatorar do SNS -->
  <!-- - refatorar do S3 -->
<!-- - refatorar default policy do SQS DLQ -->
<!-- - adicionar a opção de desativar a default policy -->
  <!-- - sns -->
  <!-- - sqs -->
  <!-- - lambda -->
  <!-- - s3 -->
<!-- - implementar triggers como sqs, sns e s3 no lambda -->
  <!-- - trigger do SQS -->
  <!-- - trigger do SNS -->
  <!-- - trigger do S3 - é configurado do lado do s3 -->
  - implementar destination no lambda
<!-- - aplicar melhorias e sugeridas do deepseek -->
  <!-- - SQS -->
  <!-- - SNS -->
  <!-- - S3 -->
  <!-- - Lambda -->
<!-- - resolver bug da horas das tags -->
<!-- - simplificar o s3 notification lambda -->
- separar a blueprint do ECS e ECS Cluster e ECS Service
  <!-- - ecs cluster  -->
  - ecs service
    <!-- - conseguir criar o service  -->
    - aplicar melhorias
      <!-- - fazer funcionar com o alb separado -->
      <!-- - rodar o ecs-service sem o alb -->
      <!-- - implementar o sistemar de worker via flag -->
      <!-- - modificar para usar a variavel container_definitions sem local -->
      <!-- - exporte autoscaling -->
      <!-- - ajusta automaticamente o tamanho da task definition -->
      - melhorar a criação do cloudwatch group
      <!-- - adicionar suporte a sidcars -->
      - adicionar suporte a alb
      - adicionar suporte a nlb
      - melhorar a interface
      - fazer o modo worker rodar em subnet privada
      - fazer o ecs service rodar em uma subnet privada
      - pensar em alguma estretegia de como usar o service_connect_configuration
      - fazer integração com o route53
  - start-and-stop task automatico - ideia de codigo no ecs cluster
<!-- - Criar blueprint para o aws ALB e NLB -->
<!-- - remover o a pastas shared e reverter suas alterações -->
<!-- - criar blueprint para o iam policy e role -->
  <!-- - ajustar variaveis de origin e destination bucket -->
  <!-- - ajustar suporte a policy statements -->
<!-- - implementar replicação do s3 -->
- melhorar a interfase da blueprint de use-cases, remover as policys
- criar blueprint do secret manager
  <!-- - versão inicial criada -->
  - add suporte a policy
- criar blueprint de dynamodb
- criar blueprint de ecr
- refatorar o EKS
- implementar testes automatizados usando o terratest
- instance ec2
  - atualizar as tags
  - Atualizar os exemplos


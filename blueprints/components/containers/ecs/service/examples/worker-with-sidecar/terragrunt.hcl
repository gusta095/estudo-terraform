include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  component_create  = true
  component_name    = "components/containers/ecs/service"
  component_version = "CHANGEME"

  service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl")).locals
}

inputs = {
  cluster_name = "gusta-ecs-test"

  container_definitions = {
    "web-test" = {
      image  = "gusta095/test-web-5000:latest"
      cpu    = 256
      memory = 512
      port_mappings = [
        {
          containerPort = 5000
        }
      ]
    }
    "logzio" = {
      image     = "gusta095/backend:e16e5e74"
      cpu       = 256
      memory    = 512
      essential = false
    }
  }

  tags = local.service_vars.tags
}

# Modo ecs_worker = true
# Quando o modo worker está ativado, são criados apenas os recursos essenciais,
# sem a necessidade de balanceamento de carga (ALB/NLB).
# Esse modo é recomendado para aplicações que atuam como consumidores ou produtores de mensagens (SQS, SNS, Kafka),
# onde o tráfego é gerenciado diretamente, sem a necessidade de um balanceador de carga.

# Modo ecs_worker = false
# Quando o modo worker está desativado , são criados recursos adicionais, como ALB,
# NLB e listeners, para oferecer suporte a aplicações mais complexas, como APIs REST, que necessitam de balanceamento
# de carga e escalabilidade. Nesse modo, as tarefas ECS ficam acessíveis através do balanceamento de carga.

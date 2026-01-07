output "service_id" {
  description = "ARN que identifica o serviço"
  value       = module.ecs_service.id
}

output "service_name" {
  description = "Nome do serviço"
  value       = module.ecs_service.name
}

output "service_iam_role_arn" {
  description = "ARN da função IAM do serviço"
  value       = module.ecs_service.iam_role_arn
}

output "service_task_definition_arn" {
  description = "ARN completo da definição de tarefa (inclui `family` e `revision`)"
  value       = module.ecs_service.task_definition_arn
}

output "service_task_exec_iam_role_arn" {
  description = "ARN da função IAM para execução de tarefas"
  value       = module.ecs_service.task_exec_iam_role_arn
}

output "service_tasks_iam_role_arn" {
  description = "ARN da função IAM para as tarefas"
  value       = module.ecs_service.tasks_iam_role_arn
}

output "service_task_set_arn" {
  description = "ARN que identifica o conjunto de tarefas"
  value       = module.ecs_service.task_set_arn
}

output "service_security_group_arn" {
  description = "ARN do grupo de segurança"
  value       = module.ecs_service.security_group_arn
}

output "service_security_group_id" {
  description = "ID do grupo de segurança"
  value       = module.ecs_service.security_group_id
}

output "service_container_definitions" {
  description = "Container definitions"
  value       = module.ecs_service.container_definitions
}

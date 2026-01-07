locals {
  # Cria a policy se a flag create_policy for true, ou se houver declarações em secrets_manager_policy_statements
  # create_policy = var.create_policy || length(var.secrets_manager_policy_statements) > 0
}

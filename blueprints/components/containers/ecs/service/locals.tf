locals {
  # Gera automaticamente as definições de containers a partir de `var.container_definitions`,
  container_definitions = [
    for name, container in var.container_definitions : merge(
      container,
      {
        name = name
        portMappings = try(
          [
            for pm in container.port_mappings : merge(pm,
              {
                name     = coalesce(pm.name, name)
                hostPort = coalesce(pm.hostPort, pm.containerPort)
              }
            )
          ], []
        )

        cloudwatch_log_group_retention_in_days = 3
      }
    )
  ]

  # Soma os valores de CPU e memória de todos os containers
  cpu    = sum([for container in var.container_definitions : container.cpu])
  memory = sum([for container in var.container_definitions : container.memory])

  # Obtém o nome e a porta do primeiro container que possui mapeamento de portas.
  container_name = [for name, c in var.container_definitions : name if length(c.port_mappings) > 0][0]
  container_port = [for c in local.container_definitions : c.port_mappings[0].containerPort if length(c.port_mappings) > 0][0]

  # Condiciona a atribuição de source_security_group_id ou cidr_blocks
  # Se 'ecs_worker' for false, a regra de tráfego para o SG vai ser o source_security_group_id
  source_security_group_id = var.ecs_worker == false ? data.aws_security_group.alb_sg[0].id : null

  # Se 'ecs_worker' for true, a regra de tráfego vai ser origem (0.0.0.0/0).
  # Apenas um desses parâmetros é configurado de cada vez para evitar conflitos.
  cidr_blocks = var.ecs_worker == true ? ["0.0.0.0/0"] : []

  # Definição dinâmica de regras do Security Group
  security_group_rules = merge(
    {
      for idx, port in distinct(flatten([
        for container in local.container_definitions : [
          for pm in container.port_mappings : pm.containerPort
        ] if length(container.port_mappings) > 0
        ])) : "ingress_${port}" => {
        type                     = "ingress"
        from_port                = port
        to_port                  = port
        protocol                 = "tcp"
        description              = "Port ${port}"
        source_security_group_id = local.source_security_group_id
        cidr_blocks              = local.cidr_blocks
      }
    },
    {
      egress_all = {
        type        = "egress"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  )

  valid_ssl_policys = [
    "ELBSecurityPolicy-2016-08",             # Padrão mais antigo, compatível com TLS 1.0, 1.1 e 1.2.
    "ELBSecurityPolicy-TLS-1-1-2017-01",     # Força o uso de TLS 1.1 e TLS 1.2, removendo suporte ao TLS 1.0.
    "ELBSecurityPolicy-TLS-1-2-2017-01",     # Apenas TLS 1.2, melhora a segurança ao remover protocolos antigos.
    "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", # TLS 1.2 com um conjunto de cifras mais restrito e seguro.
    "ELBSecurityPolicy-FS-1-2-Res-2020-10",  # TLS 1.2, otimizado para segurança forte (FS = Forward Secrecy).
    "ELBSecurityPolicy-TLS13-1-2-2021-06"    # Suporte a TLS 1.3 com fallback para TLS 1.2, oferecendo melhor desempenho e segurança.
  ]
}

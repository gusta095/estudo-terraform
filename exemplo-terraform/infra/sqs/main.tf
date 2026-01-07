provider "aws" {
  region = "us-east-1"
}

module "fila-eventos" {
  source = "git::ssh://git@gitlab.com/gusta-lab/terraform/aws/blueprints.git//components/application-integration/sqs?ref=v25.04.2"

  name = "test-sqs"

  tags = {
    Environment = "dev"
    Project     = "test-project"
  }
}
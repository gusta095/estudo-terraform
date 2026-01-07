# ------------------------------------------------------------------------------
# EC2 INSTANCE
# ------------------------------------------------------------------------------

output "instance_id" {
  description = "The instance ID"
  value       = module.ec2_instance.id
}

output "instance_ami" {
  description = "The instance AMI ID"
  value       = module.ec2_instance.ami
}

output "instance_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.ec2_instance.public_ip
}

# ------------------------------------------------------------------------------
# IAM Role
# ------------------------------------------------------------------------------

output "instance_iam_role_arn" {
  description = "The instance role ARN"
  value       = module.iam_role.iam_role_arn
}

output "instance_iam_role_name" {
  description = "The instance role name"
  value       = module.iam_role.iam_role_name
}

# ------------------------------------------------------------------------------
# KEY PAIR
# ------------------------------------------------------------------------------

output "instance_key_name" {
  description = "The key name"
  value       = aws_key_pair.this.key_name
}

# ------------------------------------------------------------------------------
# SECURITY GROUP
# ------------------------------------------------------------------------------

output "instance_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.security_group.security_group_arn
}

output "instance_security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}

output "instance_security_group_name" {
  description = "The name of the security group"
  value       = module.security_group.security_group_name
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

output "vpc_id" {
  description = "The VPC ID"
  value       = data.aws_vpc.vpc_infos.id
}

output "public_subnet_ids" {
  description = "The public list ids"
  value       = data.aws_subnets.public_subnets.ids
}

output "public_subnet_id" {
  description = "The public az a "
  value       = data.aws_subnet.public_az_a.id
}

output "public_availability_zone" {
  description = "The public az a availability_zone"
  value       = data.aws_subnet.public_az_a.availability_zone
}

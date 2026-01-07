# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "tags" {
  description = "Key-value mapping of resource tags"
  type        = map(string)
}

variable "public_key" {
  description = "The public key material"
  type        = string
}

variable "vpc_name" {
  description = "Nome da VPC da conta"
  type        = string
}

# ------------------------------------------------------------------------------
# IAM ROLE / INSTANCE PROFILE
# ------------------------------------------------------------------------------

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = true
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# EC2 INSTANCE
# ------------------------------------------------------------------------------

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
}

variable "availability_zone" {
  description = "Default availability zone"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "additional_ingress_with_cidr_blocks" {
  description = "Additional list of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "root_volume_encrypted" {
  description = "If the root disk is encrypted"
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "The type of volume. Can be 'gp3', 'gp2', 'io1', 'io2'"
  type        = string
  default     = "gp3"
}

variable "root_volume_throughput" {
  description = "The throughput of the root volume in MiB/s"
  type        = number
  default     = 125
}

variable "root_volume_size" {
  description = "The size of the root volume in gigabytes"
  type        = number
  default     = 8
}

# ------------------------------------------------------------------------------
# SECURITY GROUP
# ------------------------------------------------------------------------------

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name, need variable ingress_cidr_blocks"
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

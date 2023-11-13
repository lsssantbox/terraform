# AWS Provider Configuration
variable "aws_region" {
  description = "The AWS region where the VPC and RDS will be created."
  type        = string
  default     = "us-west-2"
}

# VPC Module Configuration
variable "name" {
  description = "The name of the VPC and other associated resources."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Enable nat gateway"
  type        = bool
  default     = true
}

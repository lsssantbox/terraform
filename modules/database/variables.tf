# AWS Provider Configuration
variable "aws_region" {
  description = "The AWS region where the VPC and RDS will be created."
  type        = string
  default     = "us-west-2"
}

variable "name" {
  description = "The name of EC2 instance to launch"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.nano"
}


variable "monitoring" {
  description = "Enable detailed monitoring for the EC2 instance"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_cidr" {
  description = "VPC CIDR block "
  type        = string
}

variable "tags" {
  description = "Tags for ec2 instance"
  type        = map(any)
}

variable "user_data" {
  description = "Tags for ec2 instance"
  type        = string
}

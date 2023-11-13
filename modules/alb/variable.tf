# AWS Provider Configuration
variable "aws_region" {
  description = "The AWS region where the VPC and RDS will be created."
  type        = string
  default     = "us-west-2"
}

variable "name" {
  description = "The name to be used on all the resources as identifier"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be created"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the ALB"
  type        = list(string)
}

variable "private_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "instance_id" {
  description = "Instance ID to associate with ALB"
  type        = string
}

variable "tags" {
  description = "Tags for ec2 instance"
  type        = map(any)
}

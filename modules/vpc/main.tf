provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}
locals {
  az_count = length(local.azs)
  azs      = data.aws_availability_zones.available.names
}

# VPC Module Configuration
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  # Input variables
  name = var.name
  cidr = var.vpc_cidr

  # Availability Zones
  azs = slice(data.aws_availability_zones.available.names, 0, local.az_count)

  # Subnet configurations
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 8)]

  enable_nat_gateway = var.enable_nat_gateway

  # Tags
  tags = var.tags
}

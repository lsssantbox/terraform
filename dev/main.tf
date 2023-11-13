terraform {
  required_version = ">= 1.4.6"
}

locals {
  environment = "Development"
  region      = "us-west-2"

  common_tags = {
    Provisioner = "Terraform"
    Environment = local.environment
  }
}

module "vpc" {
  source = "../modules/vpc"

  aws_region = local.region
  name       = "demo_structure"
  vpc_cidr   = "10.233.0.0/16"

  tags = local.common_tags
}

module "db" {
  source = "../modules/database"

  aws_region   = local.region
  name         = "mysql-dev"
  subnet_id    = element(module.vpc.database_subnets, 0)
  vpc_id       = module.vpc.vpc_id
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]

  user_data = <<-EOT
    #!/bin/bash
    python -m SimpleHTTPServer 3306 &
  EOT

  tags = local.common_tags
}

module "bastion" {
  source = "../modules/bastion"

  aws_region   = local.region
  name         = "dev"
  subnet_id    = element(module.vpc.public_subnets, 0)
  vpc_id       = module.vpc.vpc_id
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]
  admin_cidr   = "191.185.21.206/32"

  tags = local.common_tags
}

module "app" {
  source = "../modules/ec2"

  aws_region    = local.region
  name          = "app-dev"
  subnet_id     = element(module.vpc.private_subnets, 0)
  vpc_id        = module.vpc.vpc_id
  database_cidr = module.vpc.database_subnets_cidr_blocks[0]
  public_cidr   = module.vpc.public_subnets_cidr_blocks[0]

  user_data = <<-EOT
    #!/bin/bash
    python -m SimpleHTTPServer 8080 &
  EOT

  tags = local.common_tags
}

module "alb" {
  source = "../modules/alb"

  aws_region   = local.region
  name         = "app-alb"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]
  instance_id  = module.app.instance_id

  tags = local.common_tags
}

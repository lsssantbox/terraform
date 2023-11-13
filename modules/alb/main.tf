# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# ALB Module
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  # Module Inputs
  name                       = var.name
  vpc_id                     = var.vpc_id
  subnets                    = var.subnets
  enable_deletion_protection = true

  # Security Group Rules
  security_group_ingress_rules = {
    http = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    http = {
      from_port   = 8080
      to_port     = 8080
      ip_protocol = "tcp"
      cidr_ipv4   = var.private_cidr
    }
  }

  # ALB Listeners
  listeners = {
    ex_http = {
      port     = 443
      protocol = "HTTP"

      forward = {
        target_group_key = "ex-instance"
      }
    }
  }

  # ALB Target Groups
  target_groups = {
    ex-instance = {
      name_prefix                       = "h1"
      protocol                          = "HTTP"
      port                              = 8080
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false

      protocol_version = "HTTP1"
      target_id        = var.instance_id
    }
  }

  # Module Tags
  tags = var.tags
}

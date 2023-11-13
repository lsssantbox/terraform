provider "aws" {
  region = var.aws_region
}

locals {
  name = "bastion-${var.name}"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.2"

  key_name           = "${local.name}-key"
  create_private_key = true
}

# Creates and stores ssh key used creating an EC2 instance
resource "aws_secretsmanager_secret" "sm" {
  name = "${local.name}-secretmanager"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.sm.id
  secret_string = module.key_pair.private_key_pem
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name = local.name

  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_name
  monitoring                  = var.monitoring
  vpc_security_group_ids      = [module.ec2_sg.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = var.tags
}

module "ec2_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${local.name}-sg"
  description = "Security group which is used as an argument in the app"
  vpc_id      = var.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.admin_cidr
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.private_cidr
    },
  ]
}

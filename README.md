---

# AWS Infrastructure Deployment

## Overview

This project deploys AWS infrastructure using Terraform to create a *modularized architecture 

## Important
This project utilizes Terraform to orchestrate AWS infrastructure, emphasizing a modularized architecture. However, for a demo, the project intentionally embraces simplicity, acknowledging a few notable considerations:

1. **ASG Group Omission:** Instances are deployed without utilizing an Auto Scaling Group (ASG) for scalability, a decision made to streamline the demo.

2. **Module Duplication:** RDS, EC2, and Bastion modules are duplicated for simplicity, with adjustments based on specific use cases as needed.

3. **Simplified Configurations:** Configurations have been deliberately simplified, overlooking specific intricate details for clarity in the demonstration.

4. **Backend Configuration Absence:** The absence of backend configuration simplifies the project for educational purposes.

5. **Terragrunt Consideration:** In a real-world scenario, [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#introduction) would be a preferred choice for its ability to make the code DRY (Don't Repeat Yourself) and introduce additional functionalities on top of Terraform.

6. **Bastion Host Replacement:** The proposed scenario follows a traditional bastion host approach. However, in a practical setting, I recommend replacing it with Session Manager, an Amazon-recommended technology. More details on the benefits can be found [here](https://aws.amazon.com/blogs/mt/replacing-a-bastion-host-with-amazon-ec2-systems-manager/).

7. **Open for Discussion:** I am open to discussing any details and points raised in this list.


## Modules

### 1. VPC Module

Creates a Virtual Private Cloud (VPC) with specified configurations:

```hcl
module "vpc" {
  source    = "../modules/vpc"
  aws_region = local.region
  name      = "demo_structure"
  vpc_cidr  = "10.233.0.0/16"

  tags = local.common_tags
}
```

### 2. Database Module

Deploys a database instance and associates it with the VPC:

```hcl
module "db" {
  source      = "../modules/database"
  aws_region  = local.region
  name        = "mysql-dev"
  subnet_id   = element(module.vpc.database_subnets, 0)
  vpc_id      = module.vpc.vpc_id
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]

  user_data = <<-EOT
    #!/bin/bash
    python -m SimpleHTTPServer 3306 &
  EOT

  tags = local.common_tags
}
```

### 3. Bastion Module

Deploys a bastion host within the public subnet:

```hcl
module "bastion" {
  source      = "../modules/bastion"
  aws_region  = local.region
  name        = "dev"
  subnet_id   = element(module.vpc.public_subnets, 0)
  vpc_id      = module.vpc.vpc_id
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]

  tags = local.common_tags
}
```

### 4. EC2 Module

Creates an EC2 instance for the application:

```hcl
module "app" {
  source        = "../modules/ec2"
  aws_region    = local.region
  name          = "app-dev"
  subnet_id     = element(module.vpc.private_subnets, 0)
  vpc_id        = module.vpc.vpc_id
  private_cidr  = module.vpc.private_subnets_cidr_blocks[0]
  database_cidr = module.vpc.database_subnets_cidr_blocks[0]
  public_cidr   = module.vpc.public_subnets_cidr_blocks[0]

  user_data = <<-EOT
    #!/bin/bash
    python -m SimpleHTTPServer 8080 &
  EOT

  tags = local.common_tags
}
```

### 5. ALB Module

Sets up an Application Load Balancer (ALB) to distribute traffic:

```hcl
module "alb" {
  source       = "../modules/alb"
  aws_region   = local.region
  name         = "app-alb"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
  private_cidr = module.vpc.private_subnets_cidr_blocks[0]
  instance_id  = module.app.instance_id

  tags = local.common_tags
}
```

## Getting Started

To deploy the infrastructure, follow these steps:

1. Set up AWS credentials with the necessary permissions.
2. Configure your Terraform variables in the respective module directories.
3. Run `terraform init`, `terraform plan`, and `terraform apply` in the dev directory.

## Clean Up

To tear down the infrastructure, run `terraform destroy` in each module directory.

## Contributors

- Lucas Sant' Anna

---

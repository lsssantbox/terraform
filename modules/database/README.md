<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | 5.1.0 |
| <a name="module_ec2_sg"></a> [ec2\_sg](#module\_ec2\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_key_pair"></a> [key\_pair](#module\_key\_pair) | terraform-aws-modules/key-pair/aws | 2.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.sm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the VPC and RDS will be created. | `string` | `"us-west-2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of EC2 instance to launch | `string` | `"t3.nano"` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | Enable detailed monitoring for the EC2 instance | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of EC2 instance to launch | `string` | n/a | yes |
| <a name="input_private_cidr"></a> [private\_cidr](#input\_private\_cidr) | VPC CIDR block | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet in which to launch the EC2 instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for ec2 instance | `map(any)` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Tags for ec2 instance | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the EC2 instance created by the EC2 module |
<!-- END_TF_DOCS -->

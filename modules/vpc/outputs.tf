# Output the VPC ID from the VPC module
output "vpc_id" {
  description = "The ID of the VPC created by the VPC module."
  value       = module.vpc.vpc_id
}

output "default_vpc_cidr_block" {
  description = "The CIDR of the VPC created by the VPC module."
  value       = module.vpc.default_vpc_cidr_block
}

output "private_subnets_cidr_blocks" {
  description = "The private CIDR of the VPC created by the VPC module."
  value       = module.vpc.private_subnets_cidr_blocks
}

output "database_subnets_cidr_blocks" {
  description = "The Database CIDR of the VPC created by the VPC module."
  value       = module.vpc.database_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "The public CIDR of the VPC created by the VPC module."
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets" {
  description = "List of private subnets created in the VPC"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of public subnets created in the VPC"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of database subnets created in the VPC"
  value       = module.vpc.database_subnets
}

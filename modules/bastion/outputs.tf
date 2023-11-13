output "instance_id" {
  description = "ID of the EC2 instance created by the EC2 module"
  value       = module.ec2_instance.id
}

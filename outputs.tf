output "bastion_public_ip" {
  description = "Public IP of the Windows Bastion host"
  value       = module.bastion.public_ip
}

output "lamp_private_ip" {
  description = "Private IP of the LAMP server"
  value       = module.linux_vm.private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}
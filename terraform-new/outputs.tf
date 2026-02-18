output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The public IP of the Bastion Host"
}

output "backend_private_ip" {
  value       = aws_instance.backend.private_ip
  description = "The private IP of the Backend Server"
}
output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP of EC2 Instance"
  value       = aws_instance.web_server.public_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}
output "instance_id" {
  description = "ID of the EC2 application server."
  value       = aws_instance.server.id
}

output "public_ip" {
  description = "Stable Elastic IP. Point the DuckDNS A record to this address."
  value       = aws_eip.server.public_ip
}

output "ssh_command" {
  description = "SSH command for the default Ubuntu account."
  value       = "ssh ubuntu@${aws_eip.server.public_ip}"
}

output "domain_name" {
  description = "DuckDNS hostname to point at public_ip after provisioning."
  value       = var.domain_name
}

output "public_ip" {
  description = "Public IP of the Zimbra EC2 instance"
  value       = aws_instance.zimbra.public_ip
}

output "public_dns" {
  description = "Public DNS of the Zimbra EC2 instance"
  value       = aws_instance.zimbra.public_dns
}

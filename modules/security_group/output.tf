output "sg_id" {
  description = "output of Security Group ID"
  value       = aws_security_group.default_sg.id
}
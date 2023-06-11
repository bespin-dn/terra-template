output "ec2_id" {
  description = "output ec2 id"
  value       = aws_instance.default_ec2.id
}
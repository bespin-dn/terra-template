resource "aws_security_group" "default_sg" {
  vpc_id = var.vpc_id
  ingress {
    source_security_group_id = var.source_security_group_id
    from_port = var.from_port
    to_port = var.to_port
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
  tags = var.tag_name
}
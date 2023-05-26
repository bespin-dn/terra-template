resource "aws_instance" "default_ec2" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_groups
  subnet_id = var.subnet_id
  key_name = var.key_name
  associate_public_ip_address = var.public_access
  tags = var.tag_name
}
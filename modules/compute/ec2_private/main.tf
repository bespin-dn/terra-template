resource "aws_instance" "default_ec2" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_groups
  subnet_id = var.subnet_id
  key_name = var.key_name
  user_data = var.user_data
  tags = var.tag_name
}
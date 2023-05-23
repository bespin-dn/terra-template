data "aws_ami" "amzn2_ami" {
  most_recent = true

  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  owners = ["137112412989"]
}
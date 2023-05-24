resource "aws_internet_gateway" "aws_igw" {
  vpc_id = var.vpc_id
  tags = var.tag_name
}

resource "aws_eip" "aws_ngw_eip" {
  vpc = true
  tags = var.tag_name
}

resource "aws_nat_gateway" "aws_ngw" {
  allocation_id = var.public_subnet_id
  subnet_id = aws_eip.aws_ngw_eip.id

  tags = var.tag_name
}
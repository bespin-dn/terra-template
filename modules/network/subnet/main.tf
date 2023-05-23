resource "aws_subnet" "default-subnet" {
    vpc_id = var.vpc_id
    map_public_ip_on_launch = var.is_public
    cidr_block = var.cidr_block
    availability_zone = var.availability_zone
    tags = var.tag_name
}
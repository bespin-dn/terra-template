resource "aws_vpc" "default-vpc" {
    tags = var.tag_name
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
}
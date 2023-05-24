## Terraform Template 01
## main.tf

# VPC Setting
module "aws_vpc" {
  source = "../modules/network/vpc"
  cidr_block = "${var.vpc_cidr}.0.0/16"
  tag_name = {
    Name = "${var.context.project}-VPC"
    ENV = "${var.context.env}"
  }
}

# Subnet (Public)
module "aws_public_subnet_a" {
  source = "../modules/network/subnet"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = "${var.vpc_cidr}.0.0/24"
  availability_zone = "${var.context.aws_region}a"
  is_public = true
  tag_name = {
    Name = "${var.context.project}-PUB-A"
    ENV = "${var.context.env}"
  }
}
module "aws_public_subnet_c" {
  source = "../modules/network/subnet"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = "${var.vpc_cidr}.1.0/24"
  availability_zone = "${var.context.aws_region}c"
  is_public = true
  tag_name = {
    Name = "${var.context.project}-PUB-C"
    ENV = "${var.context.env}"
  }
}

# Subnet (Private)
module "aws_private_subnet_a" {
  source = "../modules/network/subnet"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = "${var.vpc_cidr}.2.0/24"
  availability_zone = "${var.context.aws_region}a"
  is_public = false
  tag_name = {
    Name = "${var.context.project}-PRI-A"
    ENV = "${var.context.env}"
  }
}
module "aws_private_subnet_c" {
  source = "../modules/network/subnet"
  vpc_id = module.aws_vpc.vpc_id
  cidr_block = "${var.vpc_cidr}.3.0/24"
  availability_zone = "${var.context.aws_region}c"
  is_public = false
  tag_name = {
    Name = "${var.context.project}-PRI-C"
    ENV = "${var.context.env}"
  }
}

#### IGW/NGW
module "aws_gateway" {
  source = "../modules/network/gateway"
  vpc_id = module.aws_vpc.vpc_id
  public_subnet_id = module.aws_public_subnet_a.subnet_id
  tag_name = {
    Name = "${var.context.project}-IGW"
    ENV = "${var.context.env}"
  }
}

## Routing 정책 + Attach

## EC2

## Security Group

## ELB
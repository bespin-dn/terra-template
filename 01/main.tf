## Terraform Template 01
## main.tf

# VPC Setting
module "aws_vpc" {
  source = "../modules/network/vpc"
  cidr_block = "${var.vpc_cidr}.0.0/16"
  tag_name = {
    Name = "${var.context.project}-VPC"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
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
    Distributor = "${var.context.distributor}"
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
    Distributor = "${var.context.distributor}"
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
    Distributor = "${var.context.distributor}"
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
    Distributor = "${var.context.distributor}"
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
    Distributor = "${var.context.distributor}"
  }
}

## Routing 정책 + Attach
resource "aws_route_table" "public_route" {
  vpc_id = module.aws_vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.aws_gateway.igw_id
  }
  tags = {
    Name = "${var.context.project}-PUB-RT"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
resource "aws_route_table" "private_route" {
  vpc_id = module.aws_vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.aws_gateway.ngw_id
  }
  tags = {
    Name = "${var.context.project}-PRI-RT"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
resource "aws_route_table_association" "to-public-a" {
  subnet_id = module.aws_public_subnet_a.subnet_id
  route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "to-public-c" {
  subnet_id = module.aws_public_subnet_c.subnet_id
  route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "to-private-a" {
  subnet_id = module.aws_private_subnet_a.subnet_id
  route_table_id = aws_route_table.private_route.id
}
resource "aws_route_table_association" "to-private-c" {
  subnet_id = module.aws_private_subnet_c.subnet_id
  route_table_id = aws_route_table.private_route.id
}

## EC2
# Bastion Host
module "aws_ec2_bastion" {
  source = "../modules/compute/ec2_bastion"
  ami_id = data.aws_ami.amzn2_ami.id
  sg_groups = [module.aws_security_group_ssh.sg_id]
  subnet_id = module.aws_public_subnet_a.subnet_id
  key_name = var.key_name
  public_access = true
  tag_name = {
    Name = "${var.context.project}-BastionHost"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
module "aws_ec2_web_a" {
  source = "../modules/compute/ec2_private"
  instance_type = var.instance_type
  ami_id = data.aws_ami.amzn2_ami.id
  sg_groups = [module.aws_security_group_internal_vpc.sg_id, module.aws_security_group_http.sg_id]
  subnet_id = module.aws_private_subnet_a.subnet_id
  key_name = var.key_name

  user_data = <<EOF
    #!/bin/bash
    echo "Inatall Nginx"
    sudo amazon-linux-extras install nginx1

    echo "Enable Systemctl"
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF

  tag_name = {
    Name = "${var.context.project}-Web"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
module "aws_ec2_web_c" {
  source = "../modules/compute/ec2_private"
  instance_type = var.instance_type
  ami_id = data.aws_ami.amzn2_ami.id
  sg_groups = [module.aws_security_group_internal_vpc.sg_id, module.aws_security_group_http.sg_id]
  subnet_id = module.aws_private_subnet_c.subnet_id
  key_name = var.key_name

  user_data = <<EOF
    #!/bin/bash
    echo "Inatall Nginx"
    sudo amazon-linux-extras install nginx1

    echo "Enable Systemctl"
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF

  tag_name = {
    Name = "${var.context.project}-Web"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
## Security Group
module "aws_security_group_ssh" {
  source = "../modules/security_group"
  name = "${var.context.project}-SSH-SG"
  vpc_id = module.aws_vpc.vpc_id
  cidr_blocks = ["165.225.228.0/23"]
  from_port = 22
  to_port = 22
  tag_name = {
    Name = "${var.context.project}-SSH-SG"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
module "aws_security_group_http" {
  source = "../modules/security_group_v2"
  name = "${var.context.project}-HTTP-SG"
  vpc_id = module.aws_vpc.vpc_id
  security_groups = [module.aws_security_group_http_lb.sg_id]
  from_port = 80
  to_port = 80
  tag_name = {
    Name = "${var.context.project}-ALB-SG"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}
module "aws_security_group_internal_vpc" {
  source = "../modules/security_group"
  name = "${var.context.project}-INTERNAL-SG"
  vpc_id = module.aws_vpc.vpc_id
  cidr_blocks = ["10.10.0.0/16"]
  from_port = 22
  to_port = 22
  tag_name = {
    Name = "${var.context.project}-INTERNAL-SG"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}

## ELB
module "aws_security_group_http_lb" {
  source = "../modules/security_group"
  name = "${var.context.project}-ALB-SG"
  vpc_id = module.aws_vpc.vpc_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 80
  to_port = 80
  tag_name = {
    Name = "${var.context.project}-ALB-SG"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }
}

module "aws_http_alb" {
  source = "../modules/network/load_balancer"
  name = "${var.context.project}-ALB"
  vpc_id = module.aws_vpc.vpc_id
  lb_type = "application"
  ec2_a_id = module.aws_ec2_web_a.ec2_id
  ec2_c_id = module.aws_ec2_web_c.ec2_id
  public_subnet_a_id = module.aws_public_subnet_a.subnet_id
  public_subnet_c_id = module.aws_public_subnet_c.subnet_id
  alb_sg_id = module.aws_security_group_http.sg_id
  tag_name = {
    Name = "${var.context.project}-ALB"
    ENV = "${var.context.env}"
    Distributor = "${var.context.distributor}"
  }

}
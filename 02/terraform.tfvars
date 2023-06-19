context = {
    aws_credentials_file = "../aws.cred"
    aws_region = "ap-southeast-2"
    aws_profile = "default"

    project = "template-01"
    env = "Dev"
    distributor = "Terraform"
}

vpc_cidr = "10.10"
instance_type = "t3.micro"
rds_type = "db.t3.micro"
key_name = "GS-Key"
variable "context" {
  type = object({
    aws_credentials_file = string
    aws_region = string
    aws_profile = string
    
    project = string
    env = string
    distributor = string
  })
}

variable "vpc_cidr" {
  description = "Network VPC CIDR"
  type = string
}

variable "instance_type" {
  description = "Instance Type of Web Instance"
  type = string
}

variable "key_name" {
  description = "Key Pair Name of EC2 Instance"
  type = string
}
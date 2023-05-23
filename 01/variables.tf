variable "context" {
  type = object({
    aws_credentials_file = string
    aws_region = string
    aws_profile = string
    project = string
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
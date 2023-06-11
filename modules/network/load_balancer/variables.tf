variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "lb_type" {
  type = string
}

variable "ec2_a_id" {
  type = string
}
variable "ec2_c_id" {
  type = string
}

variable "public_subnet_a_id" {
  type = string
}
variable "public_subnet_c_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
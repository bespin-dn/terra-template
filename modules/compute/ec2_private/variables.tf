variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "sg_groups" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "user_data" {
  type = string
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
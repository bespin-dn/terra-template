variable "key_name" {
  type = string
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

variable "pubblic_access" {
  type = bool
  default = false
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
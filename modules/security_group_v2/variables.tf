variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "from_port" {
  type = number
}
variable "to_port" {
  type = number
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
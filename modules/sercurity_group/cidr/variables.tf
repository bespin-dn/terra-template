variable "vpc_id" {
  type = string
}

variable "cidr_blocks" {
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
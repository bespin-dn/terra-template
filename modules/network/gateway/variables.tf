variable "vpc_id" {
    type = string
}

variable "public_subnet" {
  type = string
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
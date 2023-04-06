variable "cidr_blokc" {
    type = string
}

variable "is_public" {
    type = bool
    default = false
}

variable "vpc_id" {
    type = string
}

variable "availability_zone" {
    type = string
}

variable "tag_name" {
    description = "A mapping of tags"
    type = map(string)
    default = {}
}
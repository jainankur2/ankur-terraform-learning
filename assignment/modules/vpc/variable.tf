variable "account" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}


variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}
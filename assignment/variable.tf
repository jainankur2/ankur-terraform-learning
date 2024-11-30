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

variable "ami_id" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "ami_type" {
    type    = string
}
variable "disk_size" {
    type    = string
}
variable "eks_nodegroup_instance_types" {
    type    = list(string)
}
variable "desired_size" {
    type    = string
}
variable "max_size" {
    type    = string
}
variable "min_size" {
    type    = string
}
variable "account" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "vpc_id" {
    type    = string
}
variable "private_subnet_ids" {
    type    = list(string)
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

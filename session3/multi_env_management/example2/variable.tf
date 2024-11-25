variable "ami_id" {
    type = string
    default = "ami-0866a3c8686eaeeba"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}
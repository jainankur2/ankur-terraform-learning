variable "ami_id" {
    type = string
    default = "abc-1234"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "sg_ids" {
    type = list(string)
}
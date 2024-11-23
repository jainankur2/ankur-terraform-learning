variable "ami_id" {
    type = string
    default = "ami-0866a3c8686eaeeba"
}

variable "instance" {
  default = {
    "web-server" = {
        instance_type = "t3.micro"
        availability_zone = "us-east-1a"
    },
    "data-server" = {
        instance_type = "t2.micro"
        availability_zone = "us-east-1b"
    }
  }
  type = map(object({
    instance_type = string
    availability_zone = string
  }))
}
variable "ami_id" {
    type = string
    default = "ami-0866a3c8686eaeeba"
}

variable "instance" {
  default = {
    "web-server" = "t3.micro"
    "data-server" = "t2.micro"
  }
  type = map(string)
}
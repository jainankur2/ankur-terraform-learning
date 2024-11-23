variable "ingress_rules" {
  default = [{
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  },
  {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  },
  {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }]
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
}






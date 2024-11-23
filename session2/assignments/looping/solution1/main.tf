resource "aws_instance" "example" {
  count         = 3
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}
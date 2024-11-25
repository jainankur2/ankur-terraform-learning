resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  tags = {
    Name = "my-test-instance-us-east-1"
  }
}

resource "aws_instance" "web1" {
  ami           = "ami-0819a8650d771b8be"
  instance_type = "t3.micro"
  provider = aws.us-west
  tags = {
    Name = "my-test-instance-us-west-1"
  }
}

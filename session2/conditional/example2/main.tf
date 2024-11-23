resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.environment == "prod" ? "t3.micro" : "t2.micro"

  tags = {
    Name = "my-test-instance"
  }
}

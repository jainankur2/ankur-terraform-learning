resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.performance == "high" ? "t3.large" : var.performance == "medium" ? "t3.medium" : "t3.micro"

  tags = {
    Name        = "example-instance"
    Performance = var.performance
  }
}
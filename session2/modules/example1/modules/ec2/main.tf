resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_ids
  tags = {
    Name = "my-test-instance"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name      = aws_key_pair.my_key.key_name
  provisioner "file" {
    source      = "test.txt"   # Local file
    destination = "/tmp/test.txt"     # Remote destination

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> instance_ips.txt"
  }



  tags = {
    Name = "my-test-instance"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_provisioner"
  description = "Allow TLS inbound traffic and all outbound traffic"
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}



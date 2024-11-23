output "instance_ips" {
  value = aws_instance.example[*].id
}
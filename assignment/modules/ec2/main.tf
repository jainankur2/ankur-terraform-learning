resource "aws_instance" "jumpserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags          = merge(local.common_tags, { "Name" = "${local.name_suffix}-jumpserver" }, { "AutoSchedule" = "True" })
}

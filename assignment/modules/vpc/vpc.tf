resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = merge(local.common_tags, { "Name" = "${local.name_suffix}-vpc" })
}
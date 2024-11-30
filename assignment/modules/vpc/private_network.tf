resource "aws_subnet" "private-subnets" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = "false"
  availability_zone       = each.value.availability_zone
  tags                    = merge(local.common_tags, { "Name" = "${local.name_suffix}-${each.key}" })
}

resource "aws_eip" "Nat-Gateway-EIP" {
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id     = element(values(aws_subnet.public-subnets), 0).id # Attach to the first subnet dynamically
  tags          = merge(local.common_tags, { "Name" = "${local.name_suffix}-nat-gateway" })
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }
  tags = merge(local.common_tags, { "Name" = "${local.name_suffix}-nat-gateway-RT" })
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private-subnets[each.key].id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}
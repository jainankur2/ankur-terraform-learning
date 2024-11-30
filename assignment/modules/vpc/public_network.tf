resource "aws_subnet" "public-subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = each.value.availability_zone
  tags                    = merge(local.common_tags, { "Name" = "${local.name_suffix}-${each.key}" })
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.common_tags, { "Name" = "${local.name_suffix}-igw" })
}

resource "aws_route_table" "public-subnet-rt" {
  vpc_id = aws_vpc.main.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //Route table uses this IGW to reach internet
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = merge(local.common_tags, { "Name" = "${local.name_suffix}-pub-RT" })
}

resource "aws_route_table_association" "RT-public-subnet-association" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public-subnets[each.key].id
  route_table_id = aws_route_table.public-subnet-rt.id
}
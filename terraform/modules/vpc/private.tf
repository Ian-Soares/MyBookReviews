resource "aws_subnet" "private_main_subnet" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = random_shuffle.az_list.result[count.index]
  map_public_ip_on_launch = "false"

  tags = merge(
    var.tags,
    {
      "Name" = "priv-sb-${var.vpc_name}"
    }
  )
}

resource "aws_default_route_table" "private_rt_default" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = var.rt_route_cidr_block
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "priv_assoc" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private_main_subnet[count.index].id
  route_table_id = aws_default_route_table.private_rt_default.id
}